<template>
    <NavigationStu>
        <div class="home-view" activeIndex="1-4" key="nav">
            <el-row>
                <el-col :span="24">
                    <h1>查询课表</h1>
                </el-col>
            </el-row>
        </div>

        <!-- 筛选条件输入框 -->
        <el-row
            :gutter="20"
            class="filter-row"
            :style="{
                width: '70%',
                left: '50%',
                marginTop: '50px',
                position: 'relative',
                transform: 'translateX(-8%)',
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
        </el-row>

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
                prop="class_name"
                label="开设班级"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="teacher_id"
                label="教师id"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="teacher_name"
                label="教师名称"
                width="150"
            ></el-table-column>
            <el-table-column
                prop="term"
                label="开设学期"
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
    </NavigationStu>
</template>

<script>
import NavigationStu from "../components/NavigationStu.vue";
import api from "@/api/index"; // 确保此路径和您项目的API路径一致

export default {
    data() {
        return {
            selectedTerm: "",
            courses: [],
            scoreData: [],
            currentPage: 1,
            pageSize: 100,
            total: 0,
        };
    },
    components: {
        NavigationStu,
    },
    watch: {
        selectedTerm(newTerm) {
            if (newTerm) {
                this.fetchCourses();
            }
        },
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
        async fetchCourses() {
            if (this.selectedTerm) {
                try {
                    const response = await api.studentGetClassTable(
                        this.currentPage,
                        this.pageSize,
                        this.selectedTerm
                    );
                    if (response.data.code === 200) {
                        this.scoreData = response.data.data.data; // 假设返回的数据结构
                    } else {
                        this.$message.error("ERROR");
                    }
                } catch (error) {
                    console.error("Error during API call:", error);
                }
            }
        },
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
