<template>
    <Navigation>
        <div class="home-view" activeIndex="1-4" key="nav">
            <el-row>
                <el-col :span="24">
                    <h2>查看生源所在地</h2>
                    <el-text class="large-text">{{ input }}</el-text>
                </el-col>
            </el-row>
        </div>

        <el-table
            :data="hometownCountData"
            stripe
            :style="{
                width: '80%',
                left: '50%',
                marginTop: '50px',
                position: 'relative',
                transform: 'translateX(-50%)',
            }"
            :max-height="400"
            class="scrollable-table"
        >
            <el-table-column
                prop="hometown"
                label="生源所在地"
                :min-width="'50%'"
                fixed
            ></el-table-column>
            <el-table-column
                prop="count"
                label="学生数量"
                :min-width="'50%'"
            ></el-table-column>
        </el-table>

        <!-- 筛选条件输入框 -->
        <el-row
            :gutter="20"
            class="filter-row"
            :style="{
                width: '80%',
                padding: '5px 50px',
                margin: '50px auto',
                position: 'relative',
            }"
        >
            <el-col :span="4">
                <el-input
                    v-model="hometown"
                    placeholder="生源所在省"
                    clearable
                ></el-input>
            </el-col>
            <el-col :span="4">
                <el-button type="primary" @click="fetchStudents"
                    >查询</el-button
                >
            </el-col>
        </el-row>

        <el-table
            :data="studentData"
            stripe
            :style="{
                width: '80%',
                left: '50%',
                marginTop: '50px',
                position: 'relative',
                transform: 'translateX(-50%)',
            }"
            :max-height="400"
            class="scrollable-table"
        >
            <el-table-column
                prop="id"
                label="学号"
                width="150"
                fixed
            ></el-table-column>
            <el-table-column
                prop="name"
                label="学生姓名"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="gender"
                label="性别"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="age"
                label="年龄"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="hometown"
                label="生源地"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="className"
                label="班级"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="credits"
                label="所修学分"
                width="150"
            ></el-table-column>
        </el-table>

        <div class="pagination-container">
            <el-pagination
                v-model:current-page="currentPage"
                v-model:page-size="pageSize"
                :total="total"
                layout="prev, pager, next, jumper"
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
            />
        </div>
    </Navigation>
</template>

<script>
import Navigation from "../components/Navigation.vue";
import api from "@/api/index"; // 确保此路径和您项目的API路径一致

export default {
    data() {
        return {
            hometown: "",
            hometownCountData: [],
            studentData: [],
            currentPage: 1,
            pageSize: 10,
            total: 0,
        };
    },
    components: {
        Navigation,
    },
    methods: {
        handleSizeChange(size) {
            this.pageSize = size;
            this.fetchStudents();
        },
        handleCurrentChange(page) {
            this.currentPage = page;
            this.fetchStudents();
        },
        async fetchHometownCount() {
            try {
                const response = await api.hometownCount();
                if (response.data.code === 200) {
                    this.hometownCountData = response.data.data;
                } else {
                    this.$message.error("ERROR");
                }
            } catch (error) {
                console.error("Error during API call:", error);
            }
        },
        async fetchStudents() {
            try {
                const response = await api.getHometownStudent(
                    this.currentPage,
                    this.pageSize,
                    this.hometown
                );
                if (response.data.code === 200) {
                    const data = response.data.data.data;
                    this.studentData = data.map((student) => ({
                        ...student,
                        age: 2023 - Number(student.birthYear) + 1,
                    }));
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
        this.fetchHometownCount();
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

/* 筛选条件样式 */
.filter-row {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 16px;
    box-shadow: 0 8px 32px rgba(163, 97, 220, 0.1);
    border: 1px solid rgba(163, 97, 220, 0.1);
    backdrop-filter: blur(10px);
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

/* 滚动表格样式 */
.scrollable-table {
    overflow: hidden;
}

:deep(.scrollable-table .el-table__body-wrapper) {
    overflow-y: auto;
    scrollbar-width: thin;
    scrollbar-color: rgba(163, 97, 220, 0.3) transparent;
}

:deep(.scrollable-table .el-table__body-wrapper::-webkit-scrollbar) {
    width: 8px;
}

:deep(.scrollable-table .el-table__body-wrapper::-webkit-scrollbar-track) {
    background: rgba(163, 97, 220, 0.05);
    border-radius: 4px;
}

:deep(.scrollable-table .el-table__body-wrapper::-webkit-scrollbar-thumb) {
    background: rgba(163, 97, 220, 0.3);
    border-radius: 4px;
    transition: background 0.3s ease;
}

:deep(
        .scrollable-table .el-table__body-wrapper::-webkit-scrollbar-thumb:hover
    ) {
    background: rgba(163, 97, 220, 0.5);
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

/* 输入框样式 */
:deep(.el-input__wrapper) {
    background: rgba(163, 97, 220, 0.05);
    border: 2px solid rgba(163, 97, 220, 0.1);
    border-radius: 12px;
    transition: all 0.3s ease;
}

:deep(.el-input__wrapper:hover) {
    border-color: rgba(163, 97, 220, 0.3);
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.1);
}

:deep(.el-input__wrapper.is-focus) {
    border-color: #a361dc;
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.2);
}

/* 按钮样式 */
:deep(.el-button) {
    border-radius: 12px;
    font-weight: 600;
    transition: all 0.3s ease;
}

:deep(.el-button--primary) {
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    border: none;
}

:deep(.el-button--primary:hover) {
    background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(163, 97, 220, 0.4);
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

    .filter-row {
        padding: 15px;
        margin: 10px;
    }

    .demo-pagination-block {
        padding: 15px;
        margin: 10px;
    }
}
</style>
