<template>
    <NavigationStu>
        <div class="home-view" activeIndex="1-4" key="nav">
            <el-row>
                <el-col :span="24">
                    <h2>查询学年总成绩</h2>
                    <el-text class="large-text">{{ input }}</el-text>
                </el-col>
            </el-row>
        </div>

        <el-table
            :data="scoreData"
            stripe
            :style="{
                width: '80%',
                left: '50%',
                marginTop: '50px',
                position: 'relative',
                transform: 'translateX(-50%)',
            }"
        >
            <el-table-column
                prop="year"
                label="学年"
                :min-width="'33.33%'"
                sortable
            ></el-table-column>
            <el-table-column
                prop="gpa"
                label="绩点"
                :min-width="'33.33%'"
                sortable
            ></el-table-column>
            <el-table-column
                prop="credit"
                label="学分"
                sortable
                :min-width="'33.33%'"
            ></el-table-column>
        </el-table>

        <el-pagination
            v-model:current-page="currentPage"
            v-model:page-size="pageSize"
            :total="total"
            layout="prev, pager, next, jumper"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
        />
    </NavigationStu>
</template>

<script>
import NavigationStu from "../components/NavigationStu.vue";
import api from "@/api/index"; // 确保此路径和您项目的API路径一致

export default {
    data() {
        return {
            currentPage: 1,
            pageSize: 10,
            scoreData: [],
            total: 0,
            input: "查看您的学年总成绩信息",
        };
    },
    components: {
        NavigationStu,
    },
    methods: {
        handleSizeChange(size) {
            this.pageSize = size;
            this.fetchScores();
        },
        handleCurrentChange(page) {
            this.currentPage = page;
            this.fetchScores();
        },
        async fetchScores() {
            try {
                const response = await api.studentGetAllScore();
                if (response.data.code === 200) {
                    const data = response.data.data;
                    data.forEach((v) => {
                        v.gpa = Number(v.gpa);
                        if (v.gpa < 50) {
                            v.gpa = 0.0;
                        } else {
                            v.gpa = (v.gpa - 50) / 10;
                        }
                    });
                    this.scoreData = data;
                    this.total = response.data.total;
                } else {
                    this.$message.error("ERROR");
                }
            } catch (error) {
                console.error("Error during API call:", error);
            }
        },
    },
    mounted() {
        this.fetchScores();
    },
};
</script>

<style scoped>
/* 页面整体布局 */
.home-view {
    max-width: 100%;
    margin: 30px auto 0;
    text-align: center;
    color: #a361dc;
}

.home-view h2 {
    width: 1000px;
    font-size: 32px;
    font-weight: 1000;
    color: #a361dc;
    margin-bottom: 15px;
    text-shadow: 0 2px 4px rgba(163, 97, 220, 0.1);
}

.large-text {
    font-size: 18px;
    color: #8b5cf6;
    margin: 15px 0;
    display: block;
    font-weight: 500;
}

/* 表格样式 */
:deep(.el-table) {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 16px;
    box-shadow: 0 8px 32px rgba(163, 97, 220, 0.1);
    border: 1px solid rgba(163, 97, 220, 0.1);
    overflow: hidden;
    backdrop-filter: blur(10px);
}

:deep(.el-table__header) {
    background: white !important;
}

:deep(.el-table__header th) {
    background: white !important;
    color: #a361dc !important;
    font-weight: 600 !important;
    border: none !important;
}

:deep(.el-table__header th .cell) {
    color: #a361dc !important;
}

:deep(.el-table__body tr) {
    transition: all 0.3s ease;
}

:deep(.el-table__body tr:hover) {
    background: rgba(163, 97, 220, 0.05);
}

:deep(.el-table__body tr:nth-child(even)) {
    background: rgba(163, 97, 220, 0.02);
}

:deep(.el-table__body td) {
    border-bottom: 1px solid rgba(163, 97, 220, 0.1);
    color: #333;
}

:deep(.el-button--link) {
    color: #a361dc;
    font-weight: 500;
    transition: all 0.3s ease;
}

:deep(.el-button--link:hover) {
    color: #8b5cf6;
    transform: translateY(-1px);
}

/* 分页样式 */
.demo-pagination-block {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 16px;
    box-shadow: 0 8px 32px rgba(163, 97, 220, 0.1);
    border: 1px solid rgba(163, 97, 220, 0.1);
    padding: 20px;
    margin: 20px;
    backdrop-filter: blur(10px);
    text-align: center;
}

:deep(.el-pagination) {
    justify-content: center;
}

:deep(.el-pagination .el-pager li) {
    background: rgba(163, 97, 220, 0.1);
    border: 1px solid rgba(163, 97, 220, 0.2);
    color: #a361dc;
    border-radius: 8px;
    margin: 0 2px;
    transition: all 0.3s ease;
}

:deep(.el-pagination .el-pager li:hover) {
    background: rgba(163, 97, 220, 0.2);
    color: #8b5cf6;
    transform: translateY(-2px);
}

:deep(.el-pagination .el-pager li.is-active) {
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    color: white;
    border-color: #a361dc;
    box-shadow: 0 4px 15px rgba(163, 97, 220, 0.3);
}

:deep(.el-pagination .btn-prev),
:deep(.el-pagination .btn-next) {
    background: rgba(163, 97, 220, 0.1);
    border: 1px solid rgba(163, 97, 220, 0.2);
    color: #a361dc;
    border-radius: 8px;
    transition: all 0.3s ease;
}

:deep(.el-pagination .btn-prev:hover),
:deep(.el-pagination .btn-next:hover) {
    background: rgba(163, 97, 220, 0.2);
    color: #8b5cf6;
    transform: translateY(-2px);
}

/* 响应式设计 */
@media (max-width: 768px) {
    .home-view {
        padding: 20px;
        margin: 10px;
    }

    .home-view h2 {
        width: auto;
        font-size: 24px;
    }

    .demo-pagination-block {
        padding: 15px;
        margin: 10px;
    }
}
</style>
