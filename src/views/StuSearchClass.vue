<template>
    <NavigationStu>
        <div class="home-view" activeIndex="1-4" key="nav">
            <el-row>
                <el-col :span="24">
                    <h1>查看所学课程</h1>
                </el-col>
            </el-row>
        </div>

        <el-table
            :data="courseData"
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
                sortable
            ></el-table-column>
            <el-table-column
                prop="course_name"
                label="课程名称"
                width="150"
                sortable
            ></el-table-column>
            <el-table-column
                prop="teacher_id"
                label="教师编号"
                width="150"
                sortable
            ></el-table-column>
            <el-table-column
                prop="teacher_name"
                label="教师姓名"
                width="150"
                sortable
            ></el-table-column>
            <el-table-column
                prop="credit"
                label="学分"
                width="150"
                sortable
            ></el-table-column>
            <el-table-column
                prop="term"
                label="开设学期"
                width="150"
                sortable
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
            courseData: [],
            total: 0,
            terms: [
                "2023-2024(1)",
                "2023-2024(2)",
                "2024-2025(1)",
                "2024-2025(2)",
            ],
        };
    },
    components: {
        NavigationStu,
    },
    methods: {
        handleSizeChange(size) {
            this.pageSize = size;
            this.fetchAllCourses();
        },
        handleCurrentChange(page) {
            this.currentPage = page;
            this.fetchAllCourses();
        },
        async fetchAllCourses() {
            this.courseData = [];
            try {
                for (let term of this.terms) {
                    const response = await api.studentGetCourse(
                        this.currentPage,
                        this.pageSize,
                        term
                    );
                    if (response.data.code === 200) {
                        this.courseData = this.courseData.concat(
                            response.data.data.data
                        );
                    } else {
                        this.$message.error("ERROR");
                    }
                }
                this.total = this.courseData.length;
            } catch (error) {
                console.error("Error during API call:", error);
            }
        },
    },
    mounted() {
        this.fetchAllCourses();
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
