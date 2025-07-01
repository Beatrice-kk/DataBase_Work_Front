<template>
    <NavigationStu>
        <div class="home-view">
            <el-row>
                <el-col :span="24">
                    <h2>学生成绩查询</h2>
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
                <el-select
                    v-model="selectedTerm"
                    placeholder="选择学期"
                    @change="fetchCourses"
                >
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
                <el-input
                    v-model="filters.courseName"
                    placeholder="请输入课程名称"
                    clearable
                    @clear="fetchCourses"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.teacherName"
                    placeholder="请输入教师姓名"
                    clearable
                    @clear="fetchCourses"
                />
            </el-col>
            <el-col :span="4">
                <el-button type="primary" @click="fetchCourses">查询</el-button>
            </el-col>
        </el-row>

        <!-- 成绩表格 -->
        <el-table
            :data="courseData"
            stripe
            style="width: 80%; margin: 50px auto"
            :header-cell-style="{ color: 'purple' }"
        >
            <el-table-column
                prop="course_id"
                label="课程编号"
                width="120"
                sortable
            ></el-table-column>
            <el-table-column
                prop="course_name"
                label="课程名称"
                width="200"
                sortable
            ></el-table-column>
            <el-table-column
                prop="teacher_id"
                label="教师编号"
                width="120"
                sortable
            ></el-table-column>
            <el-table-column
                prop="teacher_name"
                label="教师姓名"
                width="150"
                sortable
            ></el-table-column>
            <el-table-column prop="score" label="成绩" width="100" sortable>
                <template #default="scope">
                    <el-tag
                        :type="getScoreTagType(scope.row.score)"
                        size="small"
                    >
                        {{ scope.row.score }}
                    </el-tag>
                </template>
            </el-table-column>
            <el-table-column
                prop="retake"
                label="重修状态"
                width="120"
                sortable
            >
                <template #default="scope">
                    <el-tag
                        :type="scope.row.retake ? 'danger' : 'success'"
                        size="small"
                    >
                        {{ scope.row.retake ? "重修" : "正常" }}
                    </el-tag>
                </template>
            </el-table-column>
            <el-table-column
                prop="term"
                label="学期"
                width="150"
                sortable
            ></el-table-column>
            <el-table-column fixed="right" label="操作" min-width="120">
                <template #default="scope">
                    <el-button
                        link
                        type="primary"
                        size="small"
                        @click="viewDetail(scope.row)"
                    >
                        查看详情
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <!-- 分页组件 -->
        <el-pagination
            v-model:current-page="currentPage"
            v-model:page-size="pageSize"
            :total="total"
            layout="prev, pager, next, jumper"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
        />

        <!-- 成绩详情对话框 -->
        <el-dialog
            title="成绩详情"
            v-model="detailDialogVisible"
            width="500px"
            class="styled-dialog"
        >
            <el-descriptions :column="2" border>
                <el-descriptions-item label="课程编号">
                    {{ selectedCourse.course_id }}
                </el-descriptions-item>
                <el-descriptions-item label="课程名称">
                    {{ selectedCourse.course_name }}
                </el-descriptions-item>
                <el-descriptions-item label="教师编号">
                    {{ selectedCourse.teacher_id }}
                </el-descriptions-item>
                <el-descriptions-item label="教师姓名">
                    {{ selectedCourse.teacher_name }}
                </el-descriptions-item>
                <el-descriptions-item label="成绩">
                    <el-tag
                        :type="getScoreTagType(selectedCourse.score)"
                        size="small"
                    >
                        {{ selectedCourse.score }}
                    </el-tag>
                </el-descriptions-item>
                <el-descriptions-item label="重修状态">
                    <el-tag
                        :type="selectedCourse.retake ? 'danger' : 'success'"
                        size="small"
                    >
                        {{ selectedCourse.retake ? "重修" : "正常" }}
                    </el-tag>
                </el-descriptions-item>
                <el-descriptions-item label="学期">
                    {{ selectedCourse.term }}
                </el-descriptions-item>
            </el-descriptions>
        </el-dialog>
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
            selectedTerm: "",
            courseData: [],
            total: 0,
            input: "查看您的课程成绩信息",
            detailDialogVisible: false,
            selectedCourse: {},
            filters: {
                courseName: "",
                teacherName: "",
            },
        };
    },
    components: {
        NavigationStu,
    },
    methods: {
        handleSizeChange(size) {
            this.pageSize = size;
            this.fetchCourses();
        },
        handleCurrentChange(page) {
            this.currentPage = page;
            this.fetchCourses();
        },
        async fetchCourses() {
            try {
                const response = await api.studentGetScore(
                    this.currentPage,
                    this.pageSize,
                    this.selectedTerm
                );
                if (response.data.code === 200) {
                    this.courseData = response.data.data.data;
                    this.total = response.data.data.total;
                } else {
                    this.$message.error("ERROR");
                }
            } catch (error) {
                console.error("Error during API call:", error);
            }
        },
        viewDetail(row) {
            this.selectedCourse = row;
            this.detailDialogVisible = true;
        },
        getScoreTagType(score) {
            if (score >= 90) return "success";
            if (score >= 60) return "info";
            return "danger";
        },
    },
    mounted() {
        this.fetchCourses();
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

:deep(.el-button--link) {
    color: #a361dc;
    font-weight: 500;
    transition: all 0.3s ease;
}

:deep(.el-button--link:hover) {
    color: #8b5cf6;
    transform: translateY(-1px);
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

/* 弹窗样式 */
:deep(.el-dialog) {
    border-radius: 16px;
    box-shadow: 0 20px 60px rgba(163, 97, 220, 0.2);
    border: 1px solid rgba(163, 97, 220, 0.1);
}

:deep(.el-dialog__header) {
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    color: white;
    border-radius: 16px 16px 0 0;
    padding: 20px;
}

:deep(.el-dialog__title) {
    color: white;
    font-weight: 600;
}

:deep(.el-dialog__body) {
    padding: 30px;
}

:deep(.el-descriptions__header) {
    margin-bottom: 20px;
}

:deep(.el-descriptions__title) {
    color: #a361dc;
    font-weight: 600;
}

:deep(.el-descriptions__body) {
    background: rgba(163, 97, 220, 0.02);
}

:deep(.el-descriptions__label) {
    color: #a361dc;
    font-weight: 600;
    background: rgba(163, 97, 220, 0.05);
}

:deep(.el-descriptions__content) {
    color: #333;
}

/* 标签样式 */
:deep(.el-tag) {
    border-radius: 8px;
    font-weight: 500;
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
