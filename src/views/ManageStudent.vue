<template>
    <Navigation>
        <div class="home-view" activeIndex="1-4" key="nav">
            <el-row>
                <el-col :span="24">
                    <h2>学生信息</h2>
                    <el-text class="large-text">{{ input }}</el-text>
                </el-col>
            </el-row>
            <el-button
                type="primary"
                @click="
                    clear_data();
                    dialogVisible = true;
                    fix = false;
                "
            >
                添加学生信息
            </el-button>
        </div>
        <!-- 学号查询区域 -->
        <el-row
            :gutter="20"
            class="search-by-id"
            :style="{
                width: '80%',
                padding: '10px 50px',
                margin: '20px auto',
                position: 'relative',
                background: '#f9f9f9',
                borderRadius: '8px',
            }"
        >
            <el-col :span="6">
                <el-input
                    v-model="studentId"
                    placeholder="请输入学号"
                    clearable
                />
            </el-col>
            <el-col :span="4">
                <el-button type="primary" @click="fetchStudentById"
                    >查询学号</el-button
                >
            </el-col>
        </el-row>

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
                    placeholder="请输入姓名"
                    clearable
                    @clear="fetchStudentsFind"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.gender"
                    placeholder="请输入性别"
                    clearable
                    @clear="fetchStudentsFind"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.className"
                    placeholder="请输入班级"
                    clearable
                    @clear="fetchStudentsFind"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.hometown"
                    placeholder="请输入家乡"
                    clearable
                    @clear="fetchStudentsFind"
                />
            </el-col>
            <el-col :span="4">
                <el-button type="primary" @click="fetchStudentsFind"
                    >搜索</el-button
                >
            </el-col>
        </el-row>

        <el-table
            :data="studentData"
            stripe
            style="width: 80%; margin: 50px auto"
            :header-cell-style="{ color: 'purple' }"
        >
            <el-table-column
                prop="id"
                label="学生ID"
                width="100"
                sortable
            ></el-table-column>
            <el-table-column
                prop="name"
                label="姓名"
                width="100"
                sortable
            ></el-table-column>
            <el-table-column
                prop="gender"
                label="性别"
                width="100"
                sortable
            ></el-table-column>
            <el-table-column
                prop="birthYear"
                label="年龄"
                width="100"
                sortable
            ></el-table-column>
            <el-table-column
                prop="className"
                label="班级"
                width="180"
                sortable
            ></el-table-column>
            <el-table-column
                prop="credits"
                label="学分"
                width="100"
                sortable
            ></el-table-column>
            <el-table-column
                prop="hometown"
                label="家乡"
                width="100"
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
                            fix = true;
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
                    <el-button
                        link
                        type="danger"
                        size="small"
                        @click="handleResetPassword(scope.row)"
                    >
                        重置密码
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <el-dialog title="表单弹框" v-model="dialogVisible" width="30%">
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-form-item label="学生ID" prop="id">
                    <el-input v-model.number="form.id"></el-input>
                </el-form-item>
                <el-form-item label="姓名" prop="name">
                    <el-input v-model="form.name"></el-input>
                </el-form-item>
                <el-form-item label="性别" prop="gender">
                    <el-input v-model="form.gender"></el-input>
                </el-form-item>
                <el-form-item label="年龄" prop="birth_year">
                    <el-input v-model="form.birth_year"></el-input>
                </el-form-item>
                <el-form-item label="班级" prop="class_name">
                    <el-input v-model.number="form.class_name"></el-input>
                </el-form-item>
                <el-form-item label="家乡" prop="hometown">
                    <el-input v-model="form.hometown"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="clear_data()">取消</el-button>
                <el-button type="primary" @click="submitForm()">确定</el-button>
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
import request from "../api/request"; // 引入预配置的axios实例
import api from "@/api/index";
export default {
    data() {
        return {
            studentId: "",
            fix: true,
            studentData: [],
            dialogVisible: false,
            currentPage: 1,
            pageSize: 10,
            total: 0,
            form: {
                id: null,
                name: "",
                gender: "",
                birth_year: null,
                hometown: "",
                class_name: "",
                credits: null,
            },
            filters: {
                name: "",
                gender: "",
                className: "",
                hometown: "",
            },
            rules: {
                id: [{ required: true, message: "请输入ID", trigger: "blur" }],
                name: [
                    { required: true, message: "请输入姓名", trigger: "blur" },
                ],
                gender: [
                    { required: true, message: "请输入性别", trigger: "blur" },
                ],
                birth_year: [
                    {
                        required: true,
                        message: "请输入出生年",
                        trigger: "blur",
                    },
                ],
                class_name: [
                    { required: true, message: "请输入班级", trigger: "blur" },
                ],
                hometown: [
                    { required: true, message: "请输入家乡", trigger: "blur" },
                ],
            },
        };
    },
    components: {
        Navigation,
    },
    methods: {
        async submitForm() {
            const formData = {
                ...this.form,
                id: parseInt(this.form.id),
                birth_year: parseInt(this.form.birth_year),
            };
            if (this.fix !== true) {
                try {
                    console.log(formData);
                    const response = await request.post(
                        "/api/admin/student",
                        formData
                    );
                    if (response.data.code === 200) {
                        this.$message.success("学生信息添加成功");
                        window.location.reload();
                        // 可以在这里清空表单或执行其他操作
                    } else {
                        this.$message.error("添加失败: " + response.data.msg);
                    }
                } catch (error) {
                    console.error("请求失败", error);
                    this.$message.error("请求过程中发生错误");
                }
                this.clear_data();
            } else {
                try {
                    const response = await request.put(
                        "/api/admin/student",
                        formData
                    );
                    if (response.data.code === 200) {
                        this.$message.success("学生信息修改成功");
                        // 可以在这里清空表单或执行其他操作
                    } else {
                        this.$message.error("修改失败: " + response.data.msg);
                    }
                } catch (error) {
                    console.error("请求失败", error);
                    this.$message.error("请求过程中发生错误");
                }
                this.clear_data();
                window.location.reload();
            }
        },

        handleClick(row) {
            this.currentRow = row; // 将当前行数据保存到data中的变量
            this.form.id = row.id;
            this.form.name = row.name;
            this.form.gender = row.gender;
            this.form.birth_year = row.birthYear;
            this.form.hometown = row.hometown;
            this.form.class_name = row.className;
            this.form.credits = row.credits;
            this.dialogVisible = true;
        },
        handleDelete(row) {
            api.deleteStudent(row.id);
            alert("删除成功");
            window.location.reload();
        },

        handleResetPassword(row) {
            api.resetStudentPassword(row.id);
            alert("密码重置成功");
        },

        clear_data() {
            this.form.id = null;
            this.form.name = "";
            this.form.gender = "";
            this.form.birth_year = null;
            this.form.hometown = "";
            this.form.class_name = "";
            this.form.credits = null;
            this.dialogVisible = false;
        },
        handleSizeChange(size) {
            console.log(size);
            this.pageSize = size;
            this.fetchStudents(this.currentPage, this.pageSize);
        },
        handleCurrentChange(page) {
            console.log(page);
            this.currentPage = page;
            this.fetchStudents(this.currentPage, this.pageSize);
        },
        async fetchStudents() {
            try {
                const response = await api.fetchStudent(
                    this.currentPage,
                    this.pageSize,
                    "all",
                    ""
                );
                if (response.data.code === 200) {
                    this.studentData = response.data.data.data;
                    this.total = response.data.data.total;
                    this.studentData = this.studentData.map((student) => {
                        student.birthYear = 2024 - student.birthYear;
                        return student;
                    });
                } else {
                    console.error(
                        "Failed to load student data:",
                        response.data.msg
                    );
                }
            } catch (error) {
                console.error("Error during API call:", error);
            }
        },
        async fetchStudentsFind() {
            const { name, gender, className, hometown } = this.filters;
            try {
                const response = await api.fetchStudentsFind(
                    this.currentPage,
                    this.pageSize,
                    name,
                    gender,
                    className,
                    hometown
                );
                if (response.data.code === 200) {
                    this.studentData = response.data.data.data;
                    this.studentData = this.studentData.map((student) => {
                        student.birthYear = 2024 - student.birthYear;
                        return student;
                    });
                    this.total = response.data.data.total;
                } else {
                    console.error(
                        "Failed to load student data:",
                        response.data.msg
                    );
                }
            } catch (error) {
                console.error("Error during API call:", error);
            }
        },
        async fetchStudentById() {
            const studentId = this.studentId; // 假设学号存在 this.studentId
            if (!studentId) {
                console.warn("请先输入学号");
                return;
            }
            try {
                const response = await api.fetchStudentById(studentId);
                if (response.data.code === 200) {
                    const student = response.data.data;
                    if (student) {
                        // 计算年龄，假设 birthYear 是出生年
                        student.birthYear = 2024 - student.birthYear;
                        this.studentData = [student]; // 放进数组方便渲染
                        this.total = 1;
                    } else {
                        this.studentData = [];
                        this.total = 0;
                        console.warn("未找到该学号对应的学生");
                    }
                } else {
                    console.error("加载学生数据失败:", response.data.msg);
                }
            } catch (error) {
                console.error("调用接口异常:", error);
            }
        },
    },
    async mounted() {
        this.fetchStudents(this.currentPage, this.pageSize);
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

    .home-view h1 {
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
