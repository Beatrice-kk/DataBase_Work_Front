<template>
    <NavigationTea>
        <div class="home-view" activeIndex="1-4" key="nav">
            <el-row>
                <el-col :span="24">
                    <h1>录入成绩</h1>
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
                transform: 'translateX(-30%)',
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
                <el-select
                    v-model="selectedCourse"
                    placeholder="选择课程"
                    :disabled="!selectedTerm"
                    @change="getvalue"
                >
                    <el-option
                        v-for="course in courses"
                        :key="course.course_id"
                        :label="course.course_name"
                        :value="course.course_id"
                    >
                        {{ course.course_id }} {{ course.course_name }}
                        {{ course.class_name }}
                    </el-option>
                </el-select>
            </el-col>

            <el-col :span="4">
                <el-select v-model="sortOrder" placeholder="选择排序方式">
                    <el-option label="升序" value="asc"></el-option>
                    <el-option label="降序" value="desc"></el-option>
                </el-select>
            </el-col>

            <el-col :span="4">
                <el-button
                    type="primary"
                    @click="fetchScores"
                    :disabled="!selectedCourse"
                    >查询</el-button
                >
            </el-col>
        </el-row>

        <el-row
            :gutter="50"
            class="filter-row"
            :style="{
                width: '20%',
                left: '50%',
                marginTop: '20px',
                position: 'relative',
                transform: 'translateX(-50%)',
            }"
        >
            <el-col :span="24">
                <el-tag type="info">平均成绩: {{ averageScore }}</el-tag>
            </el-col>
        </el-row>

        <el-table
            :data="sortedScoreData"
            stripe
            :style="{
                width: '80%',
                left: '50%',
                marginTop: '20px',
                position: 'relative',
                transform: 'translateX(-50%)',
            }"
        >
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
            <el-table-column fixed="right" label="录入成绩" min-width="160">
                <template #default="scope">
                    <el-button
                        link
                        type="primary"
                        size="small"
                        @click="openPopup(scope.row)"
                    >
                        编辑
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <el-dialog title="录入成绩" v-model="popupVisible" width="12%">
            <el-form :model="scoreForm">
                <el-form-item label="成绩">
                    <el-input v-model="scoreForm.score"></el-input>
                </el-form-item>
                <el-form-item style="display: flex; justify-content: center">
                    <el-button type="primary" @click="submitScore"
                        >保存</el-button
                    >
                    <el-button @click="popupVisible = false">取消</el-button>
                </el-form-item>
            </el-form>
        </el-dialog>

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
            selectedTerm: "",
            selectedCourse: "",
            selectedcourse_id: "",
            selectedclass_name: "",
            courses: [],
            scoreData: [],
            popupVisible: false,
            scoreForm: {
                student_id: "",
                term: "",
                score: "",
                class_name: "",
            },
            currentPage: 1,
            pageSize: 10,
            total: 0,
            sortOrder: "asc",
        };
    },
    components: {
        NavigationTea,
    },
    computed: {
        sortedScoreData() {
            let data = [...this.scoreData];
            if (this.sortOrder === "asc") {
                data.sort((a, b) => a.score - b.score);
            } else {
                data.sort((a, b) => b.score - a.score);
            }
            return data;
        },
        averageScore() {
            if (this.scoreData.length === 0) return 0;
            let totalScore = this.scoreData.reduce(
                (sum, item) => sum + Number(item.score),
                0
            );
            return (totalScore / this.scoreData.length).toFixed(2);
        },
    },
    methods: {
        async fetchCourses() {
            if (this.selectedTerm) {
                try {
                    const response = await api.teacherClassTable(
                        1,
                        100,
                        this.selectedTerm
                    );
                    if (response.data.code === 200) {
                        this.courses = response.data.data.data;
                        console.log(this.courses);
                    } else {
                        this.$message.error("ERROR1");
                    }
                } catch (error) {
                    console.error("Error during API call:", error);
                }
            }
            this.selectedCourse = "";
        },
        async fetchScores() {
            if (this.selectedCourse && this.selectedTerm) {
                try {
                    const response = await api.teacherGetScore(
                        this.currentPage,
                        this.pageSize,
                        this.selectedcourse_id,
                        this.selectedclass_name
                    );
                    if (response.data.code === 200) {
                        this.scoreData = response.data.data.data;
                        this.total = response.data.data.total;
                    } else {
                        this.$message.error("ERROR2");
                    }
                } catch (error) {
                    console.error("Error during API call:", error);
                }
            }
        },
        openPopup(row) {
            this.scoreForm = {
                student_id: row.student_id,
                term: this.selectedTerm,
                score: row.score,
            };
            this.popupVisible = true;
        },
        async submitScore() {
            try {
                const response = await api.teacherPostScore(
                    this.scoreForm.student_id,
                    this.selectedcourse_id,
                    this.scoreForm.score,
                    this.scoreForm.term
                );
                if (response.data.code === 200) {
                    this.$message.success("成绩录入成功");
                    this.popupVisible = false;
                    this.fetchScores();
                } else {
                    this.$message.error("ERROR3");
                }
            } catch (error) {
                console.error("Error during API call:", error);
            }
        },
        getvalue(courseId) {
            const selectedCourse = this.courses.find(
                (course) => course.course_id === courseId
            );
            this.selectedclass_name = selectedCourse.class_name;
            this.selectedcourse_id = selectedCourse.course_id;
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
