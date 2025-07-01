<template>
    <Navigation>
        <div class="home-view" activeIndex="1-4" key="nav">
            <el-row>
                <el-col :span="24">
                    <h2>课程信息</h2>
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
                添加课程信息
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
                    placeholder="请输入课程名称"
                    clearable
                    @clear="fetchCoursesFind"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.collegeName"
                    placeholder="请输入学院"
                    clearable
                    @clear="fetchCoursesFind"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.year"
                    placeholder="请输入学年"
                    clearable
                    @clear="fetchCoursesFind"
                />
            </el-col>
            <el-col :span="4">
                <el-input
                    v-model="filters.term"
                    placeholder="请输入学期"
                    clearable
                    @clear="fetchCoursesFind"
                />
            </el-col>
            <el-col :span="4">
                <el-button type="primary" @click="fetchCoursesFind"
                    >搜索</el-button
                >
            </el-col>
        </el-row>

        <el-table
            :data="courseData"
            stripe
            style="width: 80%; margin: 50px auto"
            :header-cell-style="{ color: 'purple' }"
        >
            <el-table-column
                prop="id"
                label="课程ID"
                width="80"
                sortable
            ></el-table-column>
            <el-table-column
                prop="name"
                label="课程名称"
                width="200"
                sortable
            ></el-table-column>
            <el-table-column
                prop="year"
                label="开设学年"
                width="100"
                sortable
            ></el-table-column>
            <el-table-column
                prop="term"
                label="开设学期"
                width="180"
                sortable
            ></el-table-column>
            <el-table-column
                prop="collegeName"
                label="学院"
                width="200"
                sortable
            ></el-table-column>
            <el-table-column
                prop="examinationMethod"
                label="考查方式"
                width="100"
                sortable
            ></el-table-column>
            <el-table-column
                prop="credit"
                label="学分"
                width="100"
                sortable
            ></el-table-column>
            <el-table-column
                prop="hours"
                label="学时"
                width="100"
                sortable
            ></el-table-column>
            <el-table-column
                prop="attribute"
                label="课程属性"
                width="150"
                sortable
            ></el-table-column>
            <el-table-column
                prop="examDate"
                label="考试时间"
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
                </template>
            </el-table-column>
        </el-table>

        <el-dialog title="表单弹框" v-model="dialogVisible" width="30%">
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-form-item label="课程ID" prop="id">
                    <el-input v-model.number="form.id"></el-input>
                </el-form-item>
                <el-form-item label="课程名称" prop="name">
                    <el-input v-model="form.name"></el-input>
                </el-form-item>
                <el-form-item label="开设学年" prop="year">
                    <el-input v-model="form.year"></el-input>
                </el-form-item>
                <el-form-item label="开设学期" prop="term">
                    <el-input v-model="form.term"></el-input>
                </el-form-item>
                <el-form-item label="学院" prop="college_name">
                    <el-input v-model="form.college_name"></el-input>
                </el-form-item>
                <el-form-item label="考查方式" prop="examination_method">
                    <el-input v-model="form.examination_method"></el-input>
                </el-form-item>
                <el-form-item label="学分" prop="credit">
                    <el-input v-model="form.credit"></el-input>
                </el-form-item>
                <el-form-item label="学时" prop="hours">
                    <el-input v-model="form.hours"></el-input>
                </el-form-item>
                <el-form-item label="课程属性" prop="attribute">
                    <el-input v-model="form.attribute"></el-input>
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
            fix: true,
            courseData: [],
            dialogVisible: false,
            currentPage: 1,
            pageSize: 10,
            total: 0,
            form: {
                id: null,
                name: "",
                term: "",
                college_name: "",
                examination_method: "",
                credit: "",
                hours: "",
                attribute: "",
                year: "",
            },
            rules: {
                id: [{ required: true, message: "请输入ID", trigger: "blur" }],
                name: [
                    {
                        required: true,
                        message: "请输入专业名称",
                        trigger: "blur",
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
                college_name: [
                    {
                        required: true,
                        message: "请输入学院名称",
                        trigger: "blur",
                    },
                ],
                examination_method: [
                    {
                        required: true,
                        message: "请输入考查方式",
                        trigger: "blur",
                    },
                ],
                credit: [
                    {
                        required: true,
                        message: "请输入课程学分",
                        trigger: "blur",
                    },
                ],
                hours: [
                    {
                        required: true,
                        message: "请输入课程学时",
                        trigger: "blur",
                    },
                ],
                attribute: [
                    {
                        required: true,
                        message: "请输入课程属性",
                        trigger: "blur",
                    },
                ],
            },
            filters: {
                name: "",
                collegeName: "",
                year: "",
                term: "",
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
            };
            if (this.fix !== true) {
                try {
                    console.log(formData);
                    const response = await request.post(
                        "/api/admin/course",
                        formData
                    );
                    if (response.data.code === 200) {
                        this.$message.success("专业添加成功");
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
                        "/api/admin/course",
                        formData
                    );
                    if (response.data.code === 200) {
                        this.$message.success("专业修改成功");
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
            this.form.term = row.term;
            this.form.college_name = row.collegeName;
            this.form.examination_method = row.examinationMethod;
            this.form.credit = row.credit;
            this.form.hours = row.hours;
            this.form.attribute = row.attribute;
            this.form.year = row.year;
            this.dialogVisible = true;
        },
        handleDelete(row) {
            api.deleteCourse(row.id);
            alert("删除成功");
            window.location.reload();
        },

        clear_data() {
            this.form.id = null;
            this.form.name = "";
            this.form.term = "";
            this.form.college_name = "";
            this.form.examination_method = "";
            this.form.credit = "";
            this.form.hours = "";
            this.form.attribute = "";
            this.form.year = "";
            this.dialogVisible = false;
        },
        handleSizeChange(size) {
            console.log(size);
            this.pageSize = size;
            this.fetchCourse(this.currentPage, this.pageSize);
        },
        handleCurrentChange(page) {
            console.log(page);
            this.currentPage = page;
            this.fetchCourse(this.currentPage, this.pageSize);
        },
        async fetchCourse() {
            try {
                const response = await api.fetchCourse(
                    this.currentPage,
                    this.pageSize,
                    "all",
                    ""
                );
                if (response.data.code === 200) {
                    this.courseData = response.data.data.data;
                    this.total = response.data.data.total;
                    console.log(this.courseData);
                } else {
                    console.error(
                        "Failed to load teacher data:",
                        response.data.msg
                    );
                }
            } catch (error) {
                console.error("Error during API call:", error);
            }
        },
        async fetchCoursesFind() {
            try {
                const response = await api.fetchCourse(
                    this.currentPage,
                    this.pageSize,
                    "all",
                    JSON.stringify(this.filters)
                );
                if (response.data.code === 200) {
                    this.courseData = response.data.data.data;
                    this.total = response.data.data.total;
                    console.log(this.courseData);
                } else {
                    console.error(
                        "Failed to load teacher data:",
                        response.data.msg
                    );
                }
            } catch (error) {
                console.error("Error during API call:", error);
            }
        },
    },
    async mounted() {
        this.fetchCourse(this.currentPage, this.pageSize);
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
