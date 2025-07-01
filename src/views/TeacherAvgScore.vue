<template>
    <NavigationTea>
        <div class="home-view" activeIndex="1-4" key="nav">
            <el-row>
                <el-col :span="24">
                    <h1>查询授课平均成绩课表</h1>
                </el-col>
            </el-row>
        </div>

        <el-table
            :data="resultData"
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
                prop="course_id"
                label="课程编号"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="course_name"
                label="课程名称"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="term"
                label="开设学期"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="score"
                label="平均成绩"
                width="150"
            ></el-table-column>
            <el-table-column fixed="right" label="" min-width="10">
            </el-table-column>
        </el-table>

        <div
            class="demo-pagination-block"
            :style="{
                width: '40%',
                left: '50%',
                marginTop: '50px',
                position: 'relative',
                transform: 'translateX(-15%)',
            }"
        >
            <el-pagination
                v-model:current-page="currentPage"
                v-model:page-size="pageSize"
                :total="total"
                layout="prev, pager, next, jumper"
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
            />
        </div>
    </NavigationTea>
</template>

<script>
import NavigationTea from "../components/NavigationTea.vue";
import api from "@/api/index"; // 确保此路径和您项目的API路径一致

export default {
    data() {
        return {
            courses: [],
            resultData: [],
            currentPage: 1,
            pageSize: 10,
            total: 0,
        };
    },
    components: {
        NavigationTea,
    },
    watch: {},
    methods: {
        handleSizeChange(size) {
            this.pageSize = size;
            this.fetchScores();
        },
        handleCurrentChange(page) {
            this.currentPage = page;
            this.fetchScores();
        },
        async fetchCourses() {
            try {
                const response = await api.teacherAvgScore(
                    this.currentPage,
                    this.pageSize
                );
                if (response.data.code === 200) {
                    this.resultData = response.data.data.data; // 假设返回的数据结构
                    this.total = response.data.data.total;
                } else {
                    this.$message.error("ERROR");
                }
            } catch (error) {
                console.error("Error during API call:", error);
            }
        },
    },
    async mounted() {
        this.fetchCourses();
    },
};
</script>

<style scoped>
.home-view {
    padding: 20px;
}

.large-text {
    font-size: 20px;
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
</style>
