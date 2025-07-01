<template>
    <Navigation>
        <div class="home-view" activeIndex="1-4" key="nav">
            <el-row>
                <el-col :span="24">
                    <h2>课表信息</h2>
                    <el-text class="large-text">{{ input }}</el-text>
                </el-col>
            </el-row>
            <el-button
                type="primary"
                @click="
                    clearData();
                    dialogVisible = true;
                    isEditing = false;
                "
            >
                添加课表信息
            </el-button>
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
                <el-input
                    v-model="filters.course_name"
                    placeholder="请输入课程名称"
                    clearable
                    @clear="fetchCoursesetFind"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.class_name"
                    placeholder="请输入班级名称"
                    clearable
                    @clear="fetchCoursesetFind"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.teacher_name"
                    placeholder="请输入教师姓名"
                    clearable
                    @clear="fetchCoursesetFind"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.year"
                    placeholder="请输入学年"
                    clearable
                    @clear="fetchCoursesetFind"
                />
            </el-col>
            <el-col :span="4">
                <el-button type="primary" @click="fetchCoursesetFind"
                    >搜索</el-button
                >
            </el-col>
        </el-row>

        <el-table
            :data="coursesetData"
            stripe
            style="width: 80%; margin: 50px auto"
            :header-cell-style="{ color: 'purple' }"
        >
            <el-table-column
                prop="course_id"
                label="课程编号"
                width="100"
                sortable
            ></el-table-column>
            <el-table-column
                prop="course_name"
                label="课程名称"
                width="220"
                sortable
            ></el-table-column>
            <el-table-column
                prop="class_name"
                label="班级名称"
                width="150"
                sortable
            ></el-table-column>
            <el-table-column
                prop="teacher_id"
                label="任课教师编号"
                width="150"
                sortable
            ></el-table-column>
            <el-table-column
                prop="teacher_name"
                label="任课教师姓名"
                width="150"
                sortable
            ></el-table-column>
            <el-table-column
                prop="year"
                label="开设学年"
                width="150"
                sortable
            ></el-table-column>
            <el-table-column
                prop="term"
                label="开设学期"
                width="150"
                sortable
            ></el-table-column>
            <el-table-column fixed="right" label="操作" min-width="160">
                <template #default="scope">
                    <el-button
                        link
                        type="primary"
                        size="small"
                        @click="
                            handleClick(scope.row);
                            isEditing = true;
                        "
                        style="color: white"
                    >
                        编辑
                    </el-button>
                    <el-button
                        link
                        type="danger"
                        size="small"
                        @click="handleDelete(scope.row)"
                    >
                        删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <el-dialog title="表单弹框" v-model="dialogVisible" width="30%">
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-form-item label="课程" prop="course">
                    <el-select
                        v-model="form.course_id"
                        placeholder="请选择课程"
                        @change="updateCourseInfo"
                    >
                        <el-option
                            v-for="course in courses"
                            :key="course.id"
                            :label="`${course.id} ${course.name}`"
                            :value="course.id"
                        >
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="班级名称" prop="class_name">
                    <el-select
                        v-model="form.class_name"
                        placeholder="请选择班级"
                    >
                        <el-option
                            v-for="clazz in classes"
                            :key="clazz.id"
                            :label="clazz.name"
                            :value="clazz.name"
                        ></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="任课教师" prop="teacher_id">
                    <el-select
                        v-model="form.teacher_id"
                        placeholder="请选择任课教师"
                        @change="updateTeacherName"
                    >
                        <el-option
                            v-for="teacher in teachers"
                            :key="teacher.id"
                            :label="`${teacher.name} (${teacher.id})`"
                            :value="teacher.id"
                        >
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="开设学年" prop="year">
                    <el-input v-model="form.year" disabled></el-input>
                </el-form-item>
                <el-form-item label="开设学期" prop="term">
                    <el-input v-model="form.term" disabled></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="clearData()">取消</el-button>
                <el-button type="primary" @click="submitForm">确定</el-button>
            </span>
        </el-dialog>

        <el-pagination
            v-model:current-page="currentPage"
            v-model:page-size="pageSize"
            :size="size"
            :disabled="disabled"
            :background="background"
            layout="prev, pager, next, jumper"
            :total="total"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :style="{
                width: '50%',
                left: '50%',
                marginTop: '50px',
                position: 'relative',
                transform: 'translateX(-20%)',
            }"
        />
    </Navigation>
</template>

<script>
import Navigation from "../components/Navigation.vue";
import api from "@/api/index";

export default {
    data() {
        return {
            isEditing: false,
            coursesetData: [],
            dialogVisible: false,
            currentPage: 1,
            pageSize: 10,
            total: 0,
            teachers: [],
            courses: [],
            classes: [],
            form: {
                course_id: "",
                course_name: "",
                class_name: "",
                teacher_id: "",
                teacher_name: "",
                year: "",
                term: "",
            },
            rules: {
                course_id: [
                    {
                        required: true,
                        message: "请选择课程",
                        trigger: "change",
                    },
                ],
                class_name: [
                    {
                        required: true,
                        message: "请选择班级",
                        trigger: "change",
                    },
                ],
                teacher_id: [
                    {
                        required: true,
                        message: "请选择任课教师",
                        trigger: "change",
                    },
                ],
                year: [
                    {
                        required: true,
                        message: "请输入开设学年",
                        trigger: "blur",
                    },
                ],
                term: [
                    {
                        required: true,
                        message: "请输入开设学期",
                        trigger: "blur",
                    },
                ],
            },
            filters: {
                course_name: "",
                class_name: "",
                teacher_name: "",
                year: "",
            },
        };
    },
    components: {
        Navigation,
    },
    methods: {
        async submitForm() {
            const formData = {
                course_id: this.form.course_id,
                course_name: this.form.course_name,
                class_name: this.form.class_name,
                teacher_id: this.form.teacher_id,
                teacher_name: this.form.teacher_name,
                year: this.form.year,
                term: this.form.term,
            };
            try {
                let response;
                if (this.isEditing) {
                    response = await api.updateCourseset(formData);
                } else {
                    response = await api.addCourseset(formData);
                }
                if (response.data.code === 200) {
                    this.$message.success("操作成功");
                    this.dialogVisible = false;
                    this.fetchCourseset();
                } else {
                    this.$message.error("操作失败: " + response.data.msg);
                }
            } catch (error) {
                console.error("请求失败", error);
                this.$message.error("请求过程中发生错误");
            }
        },
        handleClick(row) {
            this.form = { ...row };
            this.dialogVisible = true;
        },
        async handleDelete(row) {
            const formData = {
                course_id: row.course_id,
                course_name: row.course_name,
                class_name: row.class_name,
                teacher_id: row.teacher_id,
                teacher_name: row.teacher_name,
                year: row.year,
                term: row.term,
            };
            try {
                const response = await api.deleteCourseset(formData);
                if (response.data.code === 200) {
                    this.$message.success("删除成功");
                    this.fetchCourseset();
                } else {
                    this.$message.error("删除失败: " + response.data.msg);
                }
            } catch (error) {
                console.error("删除请求失败", error);
                this.$message.error("删除过程中发生错误");
            }
        },
        clearData() {
            this.form = {
                course_id: "",
                course_name: "",
                class_name: "",
                teacher_id: "",
                teacher_name: "",
                year: "",
                term: "",
            };
            this.dialogVisible = false;
        },
        handleSizeChange(size) {
            this.pageSize = size;
            this.fetchCourseset();
        },
        handleCurrentChange(page) {
            this.currentPage = page;
            this.fetchCourseset();
        },
        async fetchCourseset() {
            try {
                const response = await api.fetchCourseset(
                    this.currentPage,
                    this.pageSize,
                    "all",
                    ""
                );
                if (response.data.code === 200) {
                    this.coursesetData = response.data.data.data;
                    this.total = response.data.data.total;
                } else {
                    this.$message.error(
                        "获取课表数据失败: " + response.data.msg
                    );
                }
            } catch (error) {
                console.error("获取课表数据请求失败", error);
                this.$message.error("获取课表数据过程中发生错误");
            }
        },
        async fetchTeachers() {
            try {
                const response = await api.fetchTeachers(1, 100, "all", "");
                if (response.data.code === 200) {
                    this.teachers = response.data.data.data;
                } else {
                    this.$message.error(
                        "获取教师数据失败: " + response.data.msg
                    );
                }
            } catch (error) {
                console.error("获取教师数据请求失败", error);
                this.$message.error("获取教师数据过程中发生错误");
            }
        },
        async fetchCourses() {
            try {
                const response = await api.fetchCourse(1, 100, "all", "");
                if (response.data.code === 200) {
                    this.courses = response.data.data.data;
                } else {
                    this.$message.error(
                        "获取课程数据失败: " + response.data.msg
                    );
                }
            } catch (error) {
                console.error("获取课程数据请求失败", error);
                this.$message.error("获取课程数据过程中发生错误");
            }
        },
        async fetchClasses() {
            try {
                const response = await api.fetchClass(1, 100, "all", "");
                if (response.data.code === 200) {
                    this.classes = response.data.data.data;
                } else {
                    this.$message.error(
                        "获取班级数据失败: " + response.data.msg
                    );
                }
            } catch (error) {
                console.error("获取班级数据请求失败", error);
                this.$message.error("获取班级数据过程中发生错误");
            }
        },
        updateTeacherName() {
            const selectedTeacher = this.teachers.find(
                (teacher) => teacher.id === this.form.teacher_id
            );
            this.form.teacher_name = selectedTeacher
                ? selectedTeacher.name
                : "";
        },
        updateCourseInfo() {
            const selectedCourse = this.courses.find(
                (course) => course.id === this.form.course_id
            );
            if (selectedCourse) {
                this.form.course_name = selectedCourse.name;
                this.form.year = selectedCourse.year;
                this.form.term = selectedCourse.term;
            } else {
                this.form.course_name = "";
                this.form.year = "";
                this.form.term = "";
            }
        },
        async fetchCoursesetFind() {
            try {
                const response = await api.fetchCourseset(
                    this.currentPage,
                    this.pageSize,
                    "all",
                    this.filters
                );
                if (response.data.code === 200) {
                    this.coursesetData = response.data.data.data;
                    this.total = response.data.data.total;
                } else {
                    this.$message.error(
                        "获取课表数据失败: " + response.data.msg
                    );
                }
            } catch (error) {
                console.error("获取课表数据请求失败", error);
                this.$message.error("获取课表数据过程中发生错误");
            }
        },
    },
    async mounted() {
        this.fetchCourseset();
        this.fetchTeachers();
        this.fetchCourses();
        this.fetchClasses();
    },
};
</script>

<style scoped>
.home-view {
    /* width: 500px;
  padding: 10px;
  text-align: center;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 16px;
  box-shadow: 0 8px 32px rgba(163, 97, 220, 0.1);
  border: 1px solid rgba(163, 97, 220, 0.1);
  margin: 20px;
  backdrop-filter: blur(10px); */
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

.home-view :deep(.el-button--primary) {
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    border: none;
    border-radius: 12px;
    font-weight: 600;
    padding: 12px 24px;
    transition: all 0.3s ease;
    box-shadow: 0 6px 20px rgba(163, 97, 220, 0.3);
}

.home-view :deep(.el-button--primary:hover) {
    background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(163, 97, 220, 0.4);
}

.filter-row {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 16px;
    box-shadow: 0 8px 32px rgba(163, 97, 220, 0.1);
    border: 1px solid rgba(163, 97, 220, 0.1);
    padding: 20px;
    margin: 20px;
    backdrop-filter: blur(10px);
}

.filter-row :deep(.el-input__wrapper) {
    background: rgba(163, 97, 220, 0.05);
    border: 2px solid rgba(163, 97, 220, 0.1);
    border-radius: 12px;
    transition: all 0.3s ease;
}

.filter-row :deep(.el-input__wrapper:hover) {
    border-color: rgba(163, 97, 220, 0.3);
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.1);
}

.filter-row :deep(.el-input__wrapper.is-focus) {
    border-color: #a361dc;
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.2);
}

.filter-row :deep(.el-button--primary) {
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    border: none;
    border-radius: 12px;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 6px 20px rgba(163, 97, 220, 0.3);
}

.filter-row :deep(.el-button--primary:hover) {
    background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(163, 97, 220, 0.4);
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

:deep(.el-button--danger) {
    color: #f56565;
    font-weight: 500;
    transition: all 0.3s ease;
}

:deep(.el-button--danger:hover) {
    color: #e53e3e;
    transform: translateY(-1px);
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

:deep(.el-form-item__label) {
    color: #a361dc;
    font-weight: 600;
}

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
