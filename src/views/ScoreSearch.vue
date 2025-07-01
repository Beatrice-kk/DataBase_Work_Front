<template>
    <Navigation>
        <div class="home-view" activeIndex="1-4" key="nav">
            <el-row>
                <el-col :span="24">
                    <h2>成绩查询</h2>
                    <el-text class="large-text">{{ input }}</el-text>
                </el-col>
            </el-row>
        </div>

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
                <el-select v-model="selectedTerm" placeholder="选择学期">
                    <el-option
                        label="2023-2024(1)"
                        value="2023-2024(1)"
                    ></el-option>
                    <el-option
                        label="2023-2024(2)"
                        value="2023-2024(2)"
                    ></el-option>
                    <el-option
                        label="2024-2025(1)"
                        value="2024-2025(1)"
                    ></el-option>
                    <el-option
                        label="2024-2025(2)"
                        value="2024-2025(2)"
                    ></el-option>
                </el-select>
            </el-col>
            <el-col :span="4">
                <el-button type="primary" @click="fetchScore">查询</el-button>
            </el-col>
        </el-row>

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
                width="180"
            ></el-table-column>
            <el-table-column
                prop="teacher_id"
                label="教师编号"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="teacher_name"
                label="教师姓名"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="student_id"
                label="学生学号"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="student_name"
                label="学生姓名"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="score"
                label="成绩"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="retake"
                label="是否重修"
                width="150"
            ></el-table-column>
        </el-table>

        <div
            class="demo-pagination-block"
            :style="{
                width: '80%',
                left: '50%',
                marginTop: '50px',
                position: 'relative',
                transform: 'translateX(-50%)',
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
    </Navigation>
</template>

<script>
import Navigation from "../components/Navigation.vue";
import api from "@/api/index"; // 确保此路径和您项目的API路径一致

export default {
    data() {
        return {
            selectedTerm: "",
            selectedType: "",
            selectedOption: "",
            options: [],
            resultData: [],
            currentPage: 1,
            pageSize: 10,
            total: 0,
            input: "查询学生成绩信息",
        };
    },
    components: {
        Navigation,
    },
    methods: {
        handleSizeChange(size) {
            this.pageSize = size;
            this.fetchScore();
        },
        handleCurrentChange(page) {
            this.currentPage = page;
            this.fetchScore();
        },
        async fetchOptions() {
            let fetchFunction;
            if (this.selectedType === "course") {
                fetchFunction = api.fetchCourse;
            } else if (this.selectedType === "teacher") {
                fetchFunction = api.fetchTeachers;
            }

            try {
                const response = await fetchFunction(
                    this.currentPage,
                    1000,
                    "",
                    "all",
                    ""
                );
                if (response.data.code === 200) {
                    this.options = response.data.data.map((option) => ({
                        id: option.id,
                        name: option.name,
                    }));
                } else {
                    console.error("Failed to load options:", response.data.msg);
                }
            } catch (error) {
                console.error("Error during API call:", error);
            }
        },
        async fetchScore() {
            const term = this.selectedTerm;
            const type = this.selectedType || "all";
            const condition = this.selectedOption || "";
            try {
                const response = await api.fetchScore(
                    this.currentPage,
                    this.pageSize,
                    term,
                    type,
                    condition
                );
                if (response.data.code === 200) {
                    this.resultData = response.data.data.data;
                    this.total = response.data.data.total;
                } else {
                    console.error(
                        "Failed to load course data:",
                        response.data.msg
                    );
                }
            } catch (error) {
                console.error("Error during API call:", error);
            }
        },
        handleTypeChange() {
            this.selectedOption = "";
            this.options = [];
            this.fetchOptions();
        },
    },
    async mounted() {
        this.fetchScore();
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

/* 选择器样式 */
:deep(.el-select) {
    width: 100%;
}

:deep(.el-select .el-input__wrapper) {
    background: rgba(163, 97, 220, 0.05);
    border: 2px solid rgba(163, 97, 220, 0.1);
    border-radius: 12px;
    transition: all 0.3s ease;
}

:deep(.el-select .el-input__wrapper:hover) {
    border-color: rgba(163, 97, 220, 0.3);
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.1);
}

:deep(.el-select .el-input__wrapper.is-focus) {
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
