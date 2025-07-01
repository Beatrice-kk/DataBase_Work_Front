<template>
    <Navigation>
        <div class="home-view" activeIndex="1-4" key="nav">
            <el-row>
                <el-col :span="24">
                    <h2>班级信息</h2>
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
                添加班级信息
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
                    v-model="filters.name"
                    placeholder="请输入班级名称"
                    clearable
                    @clear="fetchClassFind"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.collegeName"
                    placeholder="请输入学院"
                    clearable
                    @clear="fetchClassFind"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.majorName"
                    placeholder="请输入专业"
                    clearable
                    @clear="fetchClassFind"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.teacherName"
                    placeholder="请输入班主任"
                    clearable
                    @clear="fetchClassFind"
                />
            </el-col>
            <el-col :span="4">
                <el-button type="primary" @click="fetchClassFind"
                    >搜索</el-button
                >
            </el-col>
        </el-row>

        <el-table
            :data="classData"
            stripe
            style="width: 80%; margin: 50px auto"
            :header-cell-style="{ color: 'purple' }"
        >
            <el-table-column
                prop="id"
                label="班级ID"
                width="100"
                align="right"
                sortable
            ></el-table-column>
            <el-table-column
                prop="name"
                label="班级名称"
                width="250"
                sortable
            ></el-table-column>
            <el-table-column
                prop="collegeName"
                label="学院"
                width="200"
                sortable
            ></el-table-column>
            <el-table-column
                prop="majorName"
                label="专业"
                width="200"
                sortable
            ></el-table-column>
            <el-table-column
                prop="teacherName"
                label="班主任"
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
                            handleEdit(scope.row);
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

        <el-dialog title="学生信息" v-model="dialogVisible" width="60%">
            <el-table
                :data="studentData"
                stripe
                style="width: 100%; margin: 20px auto"
                :header-cell-style="{ color: 'purple' }"
            >
                <el-table-column
                    prop="id"
                    label="学生ID"
                    width="100"
                    sortable
                />
                <el-table-column
                    prop="name"
                    label="姓名"
                    width="100"
                    sortable
                />
                <el-table-column
                    prop="gender"
                    label="性别"
                    width="100"
                    sortable
                />
                <el-table-column
                    prop="birthYear"
                    label="年龄"
                    width="100"
                    sortable
                />
                <el-table-column
                    prop="className"
                    label="班级"
                    width="180"
                    sortable
                />
                <el-table-column
                    prop="credits"
                    label="学分"
                    width="100"
                    sortable
                />
                <el-table-column
                    prop="hometown"
                    label="家乡"
                    width="100"
                    sortable
                />
            </el-table>
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
import request from "../api/request"; // 引入预配置的axios实例
import api from "@/api/index";

export default {
    data() {
        return {
            isEditing: false,
            classData: [],
            dialogVisible: false,
            currentPage: 1,
            pageSize: 10,
            total: 0,
            colleges: [],
            majors: [],
            teachers: [],
            filteredTeachers: [],
            form: {
                id: null,
                name: "",
                collegeName: "",
                majorName: "",
                teacherName: "",
            },
            rules: {
                id: [
                    {
                        required: true,
                        message: "请输入班级ID",
                        trigger: "blur",
                    },
                ],
                name: [
                    {
                        required: true,
                        message: "请输入班级名称",
                        trigger: "blur",
                    },
                ],
                collegeName: [
                    { required: true, message: "请选择学院", trigger: "blur" },
                ],
                majorName: [
                    { required: true, message: "请选择专业", trigger: "blur" },
                ],
                teacherName: [
                    {
                        required: true,
                        message: "请选择班主任",
                        trigger: "blur",
                    },
                ],
            },
            filters: {
                name: "",
                collegeName: "",
                majorName: "",
                teacherName: "",
            },
        };
    },
    components: {
        Navigation,
    },
    methods: {
        async submitForm() {
            const formData = {
                id: this.form.id,
                name: this.form.name,
                college: this.form.collegeName,
                major: this.form.majorName,
                teacher_id: this.teachers.find(
                    (teacher) => teacher.name === this.form.teacherName
                )?.id,
            };
            try {
                let response;
                if (this.isEditing) {
                    response = await request.put("/api/admin/class", formData);
                } else {
                    response = await request.post("/api/admin/class", formData);
                }
                if (response.data.code === 200) {
                    this.$message.success("操作成功");
                    this.dialogVisible = false;
                    this.fetchClass();
                } else {
                    this.$message.error("操作失败: " + response.data.msg);
                }
            } catch (error) {
                console.error("请求失败", error);
                this.$message.error("请求过程中发生错误");
            }
        },
        handleEdit(row) {
            this.form = { ...row };
            this.fetchMajors();
            this.fetchTeachersByMajor();
            this.dialogVisible = true;
        },
        async handleDelete(row) {
            try {
                const response = await api.deleteClass(row.id);
                if (response.data.code === 200) {
                    this.$message.success("删除成功");
                    this.fetchClass();
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
                id: null,
                name: "",
                collegeName: "",
                majorName: "",
                teacherName: "",
            };
            this.dialogVisible = false;
        },
        handleSizeChange(size) {
            this.pageSize = size;
            this.fetchClass();
        },
        handleCurrentChange(page) {
            this.currentPage = page;
            this.fetchClass();
        },
        async fetchClass() {
            try {
                const response = await api.fetchClass(
                    this.currentPage,
                    this.pageSize,
                    "all",
                    ""
                );
                if (response.data.code === 200) {
                    const classData = response.data.data.data;
                    const majorCollegeMap = await this.fetchMajorCollegeMap(
                        classData
                    );
                    this.classData = classData.map((cls) => ({
                        ...cls,
                        collegeName: majorCollegeMap[cls.majorName] || "未知",
                    }));
                    this.total = response.data.data.total;
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
        async fetchMajorCollegeMap(classData) {
            try {
                const majorNames = Array.from(
                    new Set(classData.map((cls) => cls.majorName))
                );
                const response = await api.fetchMajors(1, 100, "all", "");
                if (
                    response.data.code === 200 &&
                    response.data.data &&
                    response.data.data.data
                ) {
                    const majorCollegeMap = {};
                    response.data.data.data.forEach((major) => {
                        if (majorNames.includes(major.name)) {
                            majorCollegeMap[major.name] = major.collegeName;
                        }
                    });
                    return majorCollegeMap;
                } else {
                    this.$message.error(
                        "获取专业数据失败: " + response.data.msg
                    );
                    return {};
                }
            } catch (error) {
                console.error("获取专业数据请求失败", error);
                this.$message.error("获取专业数据过程中发生错误");
                return {};
            }
        },
        async fetchColleges() {
            try {
                const response = await api.fetchDepartment(1, 100, "all", "");
                if (response.data.code === 200) {
                    this.colleges = response.data.data.data.map(
                        (option) => option.name
                    );
                } else {
                    this.$message.error(
                        "获取学院数据失败: " + response.data.msg
                    );
                }
            } catch (error) {
                console.error("获取学院数据请求失败", error);
                this.$message.error("获取学院数据过程中发生错误");
            }
        },
        async fetchMajors() {
            if (!this.form.collegeName) {
                this.majors = [];
                return;
            }
            try {
                const response = await api.fetchMajors(
                    1,
                    100,
                    "college",
                    this.form.collegeName
                );
                if (response.data.code === 200) {
                    this.majors = response.data.data.data.map(
                        (option) => option.name
                    );
                } else {
                    this.$message.error(
                        "获取专业数据失败: " + response.data.msg
                    );
                }
            } catch (error) {
                console.error("获取专业数据请求失败", error);
                this.$message.error("获取专业数据过程中发生错误");
            }
            this.form.majorName = "";
            this.form.teacherName = "";
            this.filteredTeachers = [];
        },
        async fetchTeachers() {
            try {
                const response = await api.fetchTeachers(1, 100, "all", "");
                if (response.data.code === 200) {
                    this.teachers = response.data.data.data.map((teacher) => ({
                        name: teacher.name,
                        id: teacher.id,
                        major: teacher.major,
                        college: teacher.college,
                    }));
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
        fetchTeachersByMajor() {
            if (this.form.majorName) {
                this.filteredTeachers = this.teachers.filter(
                    (teacher) => teacher.college === this.form.collegeName
                );
            } else {
                this.filteredTeachers = [];
            }
        },
        async fetchClassFind() {
            await this.fetchClass();
        },
    },
    async mounted() {
        await this.fetchClass();
        await this.fetchColleges();
        await this.fetchTeachers();
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
