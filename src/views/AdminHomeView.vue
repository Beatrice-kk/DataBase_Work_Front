<template>
    <Navigation>
        <div class="home-view">
            <el-row justify="center">
                <el-col :span="24" style="text-align: center; margin-top: 60px">
                    <h2>
                        欢迎您进入学生信息管理系统
                        <el-text class="greeting-text"
                            >{{ greeting }}，管理员</el-text
                        >
                    </h2>
                </el-col>
            </el-row>
        </div>

        <div class="main-container">
            <!-- 左侧：日历区域 -->
            <div class="calendar-section">
                <el-card class="calendar-card">
                    <template #header>
                        <div class="card-header">
                            <span>📅 系统日历</span>
                        </div>
                    </template>
                    <div class="calendar-content">
                        <el-calendar v-model="value" />
                    </div>
                </el-card>
            </div>

            <!-- 中间：考试信息 -->
            <div class="exam-section">
                <el-card class="exam-info-card">
                    <template #header>
                        <div class="card-header">
                            <span>📘 考试信息</span>
                        </div>
                    </template>
                    <div class="exam-content">
                        <div v-if="allexam.length > 0" class="exam-list">
                            <div
                                v-for="(exam, index) in allexam"
                                :key="index"
                                class="exam-item"
                            >
                                <div class="exam-course">
                                    课程: {{ exam.name }}
                                </div>
                                <div class="exam-time">
                                    考试时间:
                                    {{ formatExamDate(exam.examDate) }}
                                </div>
                                <div class="exam-location" v-if="exam.location">
                                    地点: {{ exam.location }}
                                </div>
                                <el-divider v-if="index < allexam.length - 1" />
                            </div>
                        </div>
                        <div v-else class="no-exam">暂无考试信息</div>
                    </div>
                </el-card>
            </div>

            <!-- 右侧：快捷操作 -->
            <div class="action-section">
                <el-card class="action-card" style="margin-bottom: 10px">
                    <template #header>
                        <div class="card-header">
                            <span>⚙️ 快捷操作</span>
                        </div>
                    </template>
                    <div class="action-content" style="margin-top: -20px">
                        <div class="action-buttons">
                            <el-button
                                style="margin-left: 10px"
                                type="primary"
                                @click="
                                    clear_data2();
                                    dialog2Visible = true;
                                "
                                class="action-btn"
                            >
                                <span class="btn-icon">👤</span>
                                <span class="btn-text">添加管理员</span>
                            </el-button>

                            <el-button
                                type="primary"
                                @click="
                                    clear_data();
                                    dialogVisible = true;
                                "
                                class="action-btn"
                            >
                                <span class="btn-icon">🔒</span>
                                <span class="btn-text">修改密码</span>
                            </el-button>
                        </div>
                    </div>
                </el-card>
                <el-card class="action-card">
                    <template #header>
                        <div class="card-header">
                            <span>🏫 学校信息统计</span>
                        </div>
                    </template>
                    <el-descriptions :column="2" border>
                        <el-descriptions-item label="学生人数">
                            {{ schoolInfo?.studentCount ?? "加载中..." }}
                        </el-descriptions-item>
                        <el-descriptions-item label="教师人数">
                            {{ schoolInfo?.teacherCount ?? "加载中..." }}
                        </el-descriptions-item>
                        <el-descriptions-item label="课程数量">
                            {{ schoolInfo?.courseCount ?? "加载中..." }}
                        </el-descriptions-item>
                        <el-descriptions-item label="选课人次">
                            {{ schoolInfo?.enrollmentCount ?? "加载中..." }}
                        </el-descriptions-item>
                    </el-descriptions>
                </el-card>
            </div>
        </div>

        <!-- 修改密码对话框 -->
        <el-dialog
            title="修改密码"
            v-model="dialogVisible"
            width="400px"
            class="styled-dialog"
        >
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-form-item label="旧密码" prop="oldpass">
                    <el-input
                        v-model="form.oldpass"
                        show-password
                        placeholder="请输入旧密码"
                    ></el-input>
                </el-form-item>
                <el-form-item label="新密码" prop="newpass">
                    <el-input
                        v-model="form.newpass"
                        show-password
                        placeholder="请输入新密码"
                    ></el-input>
                </el-form-item>
            </el-form>
            <template #footer>
                <el-button @click="clear_data()">取消</el-button>
                <el-button
                    type="primary"
                    @click="
                        changepassword();
                        clear_data();
                    "
                    >确定</el-button
                >
            </template>
        </el-dialog>

        <!-- 添加管理员对话框 -->
        <el-dialog
            title="添加管理员账号"
            v-model="dialog2Visible"
            width="400px"
            class="styled-dialog"
        >
            <el-form
                ref="form2"
                :model="form2"
                :rules="rules2"
                label-width="100px"
            >
                <el-form-item label="管理员账号" prop="account">
                    <el-input
                        v-model="form2.account"
                        placeholder="请输入管理员账号"
                    ></el-input>
                </el-form-item>
                <el-form-item label="密码" prop="password">
                    <el-input
                        v-model="form2.password"
                        show-password
                        placeholder="请输入密码"
                    ></el-input>
                </el-form-item>
            </el-form>
            <template #footer>
                <el-button @click="clear_data2()">取消</el-button>
                <el-button
                    type="primary"
                    @click="
                        createAdmin();
                        clear_data2();
                    "
                    >确定</el-button
                >
            </template>
        </el-dialog>
    </Navigation>
</template>

<script>
import Navigation from "../components/Navigation.vue";
import api from "@/api/index.js";
import request from "@/api/request.js";

// import * as echarts from "echarts";
export default {
    name: "AdminHomeView",
    components: {
        Navigation,
    },
    data() {
        return {
            greeting: "",
            user_id: "",
            dialogVisible: false,
            dialog2Visible: false,
            input: " ",
            myChart: {},
            allexam: [],
            schoolInfo: [],
            myChartStyle: { float: "left", width: "100%", height: "400px" },
            form: {
                oldpass: "",
                newpass: "",
            },
            form2: {
                account: "",
                password: "",
            },
            rules: {
                old_pass: [
                    {
                        required: true,
                        message: "请输入旧密码",
                        trigger: "blur",
                    },
                ],
                new_pass: [
                    {
                        required: true,
                        message: "请输入新密码",
                        trigger: "blur",
                    },
                ],
            },
            rules2: {
                old_pass: [
                    {
                        required: true,
                        message: "请输入管理员账号",
                        trigger: "blur",
                    },
                ],
                new_pass: [
                    { required: true, message: "请输入密码", trigger: "blur" },
                ],
            },
            value: new Date(),
            examMap: {}, // { "2024-07-12": { courseName: "高等数学", ... } }
        };
    },
    methods: {
        formatExamDate(datetimeStr) {
            if (!datetimeStr) return "";
            return datetimeStr.replace("T", " ");
        },
        clear_data() {
            this.form.oldpass = "";
            this.form.newpass = "";
            this.dialogVisible = false;
        },
        clear_data2() {
            this.form2.account = "";
            this.form2.password = "";
            this.dialog2Visible = false;
        },
        async changepassword() {
            try {
                const response = await api.adminChangePassword(
                    this.form.oldpass,
                    this.form.newpass
                );
                if (response.data.code === 200) {
                    this.$message.success("密码修改成功");
                } else {
                    this.$message.error("密码修改失败");
                }
            } catch (error) {
                console.error("请求失败", error);
                this.$message.error("请求过程中发生错误");
            }
        },
        async createAdmin() {
            const response = await api.addAdmin(
                this.form2.account,
                this.form2.password
            );
            if (response.data.code === 200) {
                this.$message.success("账号创建成功");
            } else {
                this.$message.error("账号创建失败");
            }
        },
        //-------------------------------
        //   getExamData() {
        //       api.fetchExamCourses()
        //           .then((res) => {
        //               const data = res.data.data || [];
        //               const map = {};
        //               data.forEach((item) => {
        //                   map[item.examDate] = item;
        //               });
        //               this.examMap = map;
        //               this.allexam = data;
        //               //   this.input = `今天是 ${new Date().toLocaleDateString()}，你有 ${
        //               //       data.length
        //               //   } 门考试。`;
        //           })
        //           .catch((err) => {
        //               console.error("获取考试信息失败", err);
        //           });
        //   },

        async getExamData() {
            try {
                const res = await api.fetchExamCourses();
                console.log(res);
                if (res.data.code === 200) {
                    const sortedData = res.data.data.sort(
                        (a, b) => new Date(a.examDate) - new Date(b.examDate)
                    );

                    this.allexam = sortedData;
                } else {
                    this.$message.error("获取考试信息失败");
                }
            } catch (error) {
                console.log("获取考试信息时发生错误", error);
            }
        },
        async getSchoolInfo() {
            try {
                const res = await api.fetchSchoolInfo();
                console.log(res);
                if (res.data.code == 200) {
                    this.schoolInfo = res.data.data;
                } else {
                    this.$message.error("获取学校信息失败");
                }
            } catch (error) {
                console.log("学校信息失败获取", error);
            }
        },
        //---------------------
    },
    created() {
        this.getExamData();
        this.getSchoolInfo();
        const hour = new Date().getHours();
        if (hour < 12) {
            this.greeting = "早上好";
        } else if (hour < 18) {
            this.greeting = "下午好";
        } else {
            this.greeting = "晚上好";
        }
    },

    mounted() {},

    //-----------
};
</script>
<!-- //#################################333333333333333333333333333333333333333#########################################
 333333333333333333333333333333333333#######################################################################? -->
<style scoped>
.greeting-text {
    font-size: 20px;
    font-weight: bold;
    color: #409eff;
    margin-top: 20px;
}
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

.main-container {
    display: flex;
    justify-content: space-between;
    align-items: stretch;
    margin: 50px auto;
    max-width: 1400px;
    gap: 30px;
    padding: 0 20px;
    min-height: 600px; /* 确保容器有最小高度 */
}

/* 通用卡片样式 */
.calendar-section,
.exam-section,
.action-section {
    display: flex;
    flex-direction: column;
}

.calendar-section {
    flex: 2;
    min-width: 400px;
}

.exam-section {
    flex: 1.5;
    min-width: 350px;
}

.action-section {
    flex: 1;
    min-width: 280px;
}

.calendar-card,
.exam-info-card,
.action-card {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 16px;
    box-shadow: 0 8px 32px rgba(163, 97, 220, 0.1);
    border: 1px solid rgba(163, 97, 220, 0.1);
    backdrop-filter: blur(10px);
    height: 100%;
    display: flex;
    flex-direction: column;
}

/* 卡片内容区域 */
.calendar-content,
.exam-content {
    height: 450px;
    flex: 1;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

/* 日历内容样式 */
.calendar-content {
    overflow: hidden;
}

/* 考试信息内容样式 */
.exam-content {
    overflow: hidden;
}

/* 快捷操作内容样式 */
.action-content {
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 20px 0;
}

/* 卡片头部样式 */
.card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    flex-shrink: 0; /* 防止头部被压缩 */
}

.card-header span {
    font-size: 20px;
    font-weight: 600;
    color: #a361dc;
}

.action-buttons {
    display: flex;
    flex-direction: column;
    align-items: stretch; /* 或使用 width: 100% */
    gap: 20px;
    width: 80%; /* 确保按钮可以拉伸占满整行 */
    padding-left: 10%;
}

.action-btn {
    height: 70px;
    width: 100%;
    font-size: 16px;
    font-weight: 600;
    color: white;
    border: none;
    border-radius: 12px;
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    box-shadow: 0 6px 20px rgba(163, 97, 220, 0.3);
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
    position: relative;
    overflow: hidden;
}

.action-btn::before {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(
        90deg,
        transparent,
        rgba(255, 255, 255, 0.2),
        transparent
    );
    transition: left 0.5s;
}

.action-btn:hover::before {
    left: 100%;
}

.action-btn:hover {
    background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
    transform: translateY(-3px);
    box-shadow: 0 10px 30px rgba(163, 97, 220, 0.4);
}

.action-btn:active {
    transform: translateY(-1px);
    box-shadow: 0 6px 20px rgba(163, 97, 220, 0.3);
}

.btn-icon {
    font-size: 24px;
    filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
}

.btn-text {
    font-size: 16px;
    font-weight: 600;
    letter-spacing: 0.5px;
}

/* 考试信息样式 */
.exam-list {
    flex: 1;
    overflow-y: auto;
    padding: 10px;
    max-height: 400px; /* 限制最大高度，确保可滚动 */
    scrollbar-width: thin;
    scrollbar-color: rgba(163, 97, 220, 0.3) transparent;
}

/* 自定义滚动条样式 */
.exam-list::-webkit-scrollbar {
    width: 6px;
}

.exam-list::-webkit-scrollbar-track {
    background: rgba(163, 97, 220, 0.05);
    border-radius: 3px;
}

.exam-list::-webkit-scrollbar-thumb {
    background: rgba(163, 97, 220, 0.3);
    border-radius: 3px;
    transition: background 0.3s ease;
}

.exam-list::-webkit-scrollbar-thumb:hover {
    background: rgba(163, 97, 220, 0.5);
}

.exam-item {
    padding: 15px;
    margin-bottom: 10px;
    background: rgba(163, 97, 220, 0.05);
    border-radius: 12px;
    border: 1px solid rgba(163, 97, 220, 0.1);
    transition: all 0.3s ease;
}

.exam-item:hover {
    background: rgba(163, 97, 220, 0.1);
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(163, 97, 220, 0.2);
}

.exam-course {
    font-size: 16px;
    font-weight: 600;
    color: #a361dc;
    margin-bottom: 8px;
}

.exam-time,
.exam-location {
    font-size: 14px;
    color: #666;
    margin-bottom: 5px;
}

.no-exam {
    text-align: center;
    color: #999;
    padding: 40px 20px;
    font-size: 16px;
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* Element UI 组件样式 */
:deep(.el-calendar) {
    background: transparent;
    flex: 1;
    display: flex;
    flex-direction: column;
}

:deep(.el-calendar__header) {
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    color: white;
    border-radius: 12px 12px 0 0;
    padding: 15px;
}

:deep(.el-calendar__title) {
    color: rgb(23, 214, 83);
    font-weight: 600;
}

:deep(.el-calendar__body) {
    padding: 20px;
    flex: 1;
}

:deep(.el-calendar-table) {
    height: 100%;
}

:deep(.el-calendar-table th) {
    background: rgba(163, 97, 220, 0.1);
    color: #a361dc;
    font-weight: 600;
    border: none;
}

:deep(.el-calendar-table td) {
    border: 1px solid rgba(163, 97, 220, 0.1);
    transition: all 0.3s ease;
}

:deep(.el-calendar-table td:hover) {
    background: rgba(163, 97, 220, 0.05);
}

:deep(.el-calendar-table .is-today) {
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    color: white;
    border-radius: 8px;
}

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

:deep(.el-divider) {
    border-color: rgba(163, 97, 220, 0.1);
    margin: 15px 0;
}

/* 响应式设计 */
@media (max-width: 1200px) {
    .main-container {
        flex-direction: column;
        gap: 20px;
        align-items: stretch;
    }

    .calendar-section,
    .exam-section,
    .action-section {
        min-width: auto;
        width: 100%;
        height: auto;
    }

    .calendar-card,
    .exam-info-card,
    .action-card {
        height: auto;
        min-height: 400px;
    }

    .home-view h2 {
        width: auto;
        font-size: 28px;
    }
}

@media (max-width: 768px) {
    .main-container {
        margin: 30px 10px;
        padding: 0 10px;
    }

    .home-view h2 {
        font-size: 24px;
    }

    .card-header span {
        font-size: 18px;
    }

    .action-btn {
        height: 50px;
        font-size: 14px;
    }

    .btn-icon {
        font-size: 18px;
    }

    .btn-text {
        font-size: 14px;
    }

    .exam-course {
        font-size: 14px;
    }

    .exam-time,
    .exam-location {
        font-size: 12px;
    }
}
</style>
