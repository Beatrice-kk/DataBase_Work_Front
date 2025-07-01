<template>
    <div class="login-container">
        <div class="background-wrapper">
            <img :src="login_background" :style="backgroundStyle" />
        </div>
        <div class="worker-wrapper">
            <img :src="worker" :style="workerStyle" />
        </div>
        <el-card class="login-box">
            <div class="login-header">
                <h2 class="system-title">学生成绩管理系统</h2>
                <h3 class="login-subtitle">账户登录</h3>
            </div>
            <div class="login-form">
                <el-select
                    v-model="value"
                    placeholder="请选择用户类型"
                    class="login-select"
                >
                    <el-option
                        v-for="item in options"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value"
                    />
                </el-select>
                <el-input
                    v-model="username"
                    class="login-input"
                    placeholder="请输入用户名"
                    prefix-icon="User"
                />
                <el-input
                    v-model="password"
                    type="password"
                    class="login-input"
                    placeholder="请输入密码"
                    prefix-icon="Lock"
                    show-password
                />
                <el-button @click="login" class="login-button">
                    登录
                </el-button>
                <div class="password-hint">
                    <el-text class="hint-text">
                        💡 默认密码：zjut + 用户名
                    </el-text>
                </div>
                <div class="forgot-password">
                    <el-link
                        type="primary"
                        @click="showForgotPasswordDialog"
                        class="forgot-link"
                    >
                        忘记密码？
                    </el-link>
                </div>
            </div>
        </el-card>

        <!-- 忘记密码对话框 -->
        <el-dialog
            style="border-radius: 20px"
            v-model="forgotPasswordVisible"
            title="忘记密码"
            width="500px"
            :close-on-click-modal="false"
            :close-on-press-escape="false"
            class="forgot-password-dialog"
        >
            <div class="forgot-password-steps">
                <!-- 步骤1：输入账号 -->
                <div v-if="currentStep === 1" class="step-content">
                    <div class="step-title">
                        <el-icon class="step-icon"><User /></el-icon>
                        <span>第一步：输入账号</span>
                    </div>
                    <el-select
                        v-model="forgotUserType"
                        placeholder="请选择用户类型"
                        class="forgot-select"
                    >
                        <el-option
                            v-for="item in options"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value"
                        />
                    </el-select>
                    <el-input
                        v-model="forgotUsername"
                        placeholder="请输入账号"
                        class="forgot-input"
                        prefix-icon="User"
                    />
                </div>

                <!-- 步骤2：回答问题 -->
                <div v-if="currentStep === 2" class="step-content">
                    <div class="step-title">
                        <el-icon class="step-icon"><QuestionFilled /></el-icon>
                        <span>第二步：验证身份</span>
                    </div>
                    <div class="question-box">
                        <p class="question-text">
                            浙江工业大学的四字校训是什么？
                        </p>
                        <el-input
                            v-model="securityAnswer"
                            placeholder="请输入答案"
                            class="forgot-input"
                            prefix-icon="Key"
                        />
                    </div>
                </div>

                <!-- 步骤3：修改密码 -->
                <div v-if="currentStep === 3" class="step-content">
                    <div class="step-title">
                        <el-icon class="step-icon"><Lock /></el-icon>
                        <span>第三步：设置新密码</span>
                    </div>
                    <el-input
                        v-model="newPassword"
                        type="password"
                        placeholder="请输入新密码"
                        class="forgot-input"
                        prefix-icon="Lock"
                        show-password
                    />
                    <el-input
                        v-model="confirmPassword"
                        type="password"
                        placeholder="请确认新密码"
                        class="forgot-input"
                        prefix-icon="Lock"
                        show-password
                    />
                </div>
            </div>

            <template #footer>
                <div class="dialog-footer">
                    <el-button @click="cancelForgotPassword">取消</el-button>
                    <el-button
                        v-if="currentStep > 1"
                        @click="previousStep"
                        type="info"
                    >
                        上一步
                    </el-button>
                    <el-button
                        style="background-color: #a361dc"
                        v-if="currentStep < 3"
                        @click="nextStep"
                        type="primary"
                    >
                        下一步
                    </el-button>
                    <el-button
                        v-if="currentStep === 3"
                        @click="submitPasswordChange"
                        type="success"
                        :loading="submitting"
                    >
                        确认修改
                    </el-button>
                </div>
            </template>
        </el-dialog>
    </div>
</template>

<script>
import axios from "axios";
import request from "@/api/request";
import api from "@/api/index";
import { ElMessage } from "element-plus";
import { User, QuestionFilled, Lock } from "@element-plus/icons-vue";

export default {
    components: {
        User,
        QuestionFilled,
        Lock,
    },
    data() {
        return {
            value: "Manager", // 默认选择管理员
            username: "",
            password: "",
            login_background: require("@/assets/img/login_background.png"),
            options: [
                { value: "Student", label: "学生" },
                { value: "Teacher", label: "教师" },
                { value: "Manager", label: "管理员" },
            ],
            // 忘记密码相关数据
            forgotPasswordVisible: false,
            currentStep: 1,
            forgotUserType: "Manager",
            forgotUsername: "",
            securityAnswer: "",
            newPassword: "",
            confirmPassword: "",
            submitting: false,
        };
    },
    computed: {
        backgroundStyle() {
            return {
                position: "fixed",
                top: "0",
                left: "0",
                width: "100vw",
                height: "100vh",
                objectFit: "cover",
                zIndex: "-1",
            };
        },
    },
    methods: {
        async login() {
            if (this.value === "Manager") {
                this.admin_login();
            } else if (this.value === "Teacher") {
                this.teacher_login();
            } else if (this.value === "Student") {
                this.student_login();
            }
        },
        async admin_login() {
            try {
                const params = new URLSearchParams();
                params.append("id", this.username);
                params.append("password", this.password);

                const response = await request.post("/api/admin/login", params);
                console.log(response.data); // 打印接收到的数据

                if (response.data.code === 200) {
                    // 检查 code 字段
                    const token = response.data.data;
                    sessionStorage.setItem("Authorization", token); // 存储到 sessionStorage
                    this.$router.push("/admin/home");
                } else {
                    ElMessage.error("Login failed: " + response.data.msg);
                }
            } catch (error) {
                console.error("Error during login:", error);
                ElMessage.error(" occurred. Please try again.");
            }
        },
        async teacher_login() {
            try {
                const params = new URLSearchParams();
                params.append("id", this.username);
                params.append("password", this.password);

                const response = await request.post(
                    "/api/teacher/login",
                    params
                );
                console.log(response.data); // 打印接收到的数据
                if (response.data.code === 200) {
                    // 检查 code 字段
                    const token = response.data.data;
                    sessionStorage.setItem("Authorization", token); // 存储到 sessionStorage
                    this.$router.push("/teacher/home");
                } else {
                    ElMessage.error("Login failed: " + response.data.msg);
                }
            } catch (error) {
                console.error("Error during login:", error);
                ElMessage.error("An error occurred. Please try again.");
            }
        },
        async student_login() {
            try {
                const params = new URLSearchParams();
                params.append("id", this.username);
                params.append("password", this.password);

                const response = await request.post(
                    "/api/student/login",
                    params
                );
                console.log(response.data); // 打印接收到的数据
                if (response.data.code === 200) {
                    // 检查 code 字段
                    const token = response.data.data;
                    sessionStorage.setItem("Authorization", token); // 存储到 sessionStorage
                    this.$router.push("/student/home");
                } else {
                    ElMessage.error("Login failed: " + response.data.msg);
                }
            } catch (error) {
                console.error("Error during login:", error);
                ElMessage.error("An error occurred. Please try again.");
            }
        },
        keyDown(e) {
            if (e.keyCode === 13) {
                this.login();
                document.removeEventListener("keydown", this.keyDown);
            }
        },
        // 忘记密码相关方法
        showForgotPasswordDialog() {
            this.forgotPasswordVisible = true;
            this.resetForgotPasswordData();
        },
        resetForgotPasswordData() {
            this.currentStep = 1;
            this.forgotUserType = "Manager";
            this.forgotUsername = "";
            this.securityAnswer = "";
            this.newPassword = "";
            this.confirmPassword = "";
            this.submitting = false;
        },
        cancelForgotPassword() {
            this.forgotPasswordVisible = false;
            this.resetForgotPasswordData();
        },
        nextStep() {
            if (this.currentStep === 1) {
                if (!this.forgotUsername.trim()) {
                    ElMessage.warning("请输入账号");
                    return;
                }
                this.currentStep = 2;
            } else if (this.currentStep === 2) {
                if (!this.securityAnswer.trim()) {
                    ElMessage.warning("请输入答案");
                    return;
                }
                if (this.securityAnswer.trim() !== "厚德健行") {
                    ElMessage.error("答案错误，请重新输入");
                    return;
                }
                this.currentStep = 3;
            }
        },
        previousStep() {
            if (this.currentStep > 1) {
                this.currentStep--;
            }
        },
        async submitPasswordChange() {
            // 验证输入
            if (!this.newPassword.trim()) {
                ElMessage.warning("请输入新密码");
                return;
            }
            if (this.newPassword !== this.confirmPassword) {
                ElMessage.error("两次输入的新密码不一致");
                return;
            }
            if (this.newPassword.length < 6) {
                ElMessage.warning("新密码长度不能少于6位");
                return;
            }

            this.submitting = true;
            try {
                let response;
                if (this.forgotUserType === "Manager") {
                    response = await api.adminChangePasswordWithoutLogin(
                        this.forgotUsername,
                        this.newPassword
                    );
                } else if (this.forgotUserType === "Teacher") {
                    response = await api.teacherChangePasswordWithoutLogin(
                        this.forgotUsername,
                        this.newPassword
                    );
                } else if (this.forgotUserType === "Student") {
                    response = await api.studentChangePasswordWithoutLogin(
                        this.forgotUsername,
                        this.newPassword
                    );
                }

                if (response.data.code === 200) {
                    ElMessage.success("密码修改成功！");
                    this.cancelForgotPassword();
                } else {
                    ElMessage.error("密码修改失败：" + response.data.msg);
                }
            } catch (error) {
                console.error("Password change error:", error);
                ElMessage.error("密码修改失败，请检查新密码是否正确");
            } finally {
                this.submitting = false;
            }
        },
    },
    mounted() {
        window.addEventListener("keydown", this.keyDown);
    },
    beforeDestroy() {
        window.removeEventListener("keydown", this.keyDown);
    },
};
</script>

<style scoped>
.login-container {
    position: relative;
    width: 100vw;
    height: 100vh;
    overflow: hidden;
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
}

.background-wrapper {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    z-index: 1;
}

.background-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    opacity: 0.3;
}

.worker-wrapper {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    z-index: 2;
}

.login-box {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 400px;
    padding: 40px;
    background: rgba(255, 255, 255, 0.95);
    border-radius: 20px;
    box-shadow: 0 20px 60px rgba(163, 97, 220, 0.2);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(163, 97, 220, 0.1);
    z-index: 10;
    transition: all 0.3s ease;
}

.login-box:hover {
    transform: translate(-50%, -50%) translateY(-5px);
    box-shadow: 0 30px 80px rgba(163, 97, 220, 0.3);
}

.login-header {
    text-align: center;
    margin-bottom: 30px;
}

.system-title {
    font-size: 28px;
    font-weight: 700;
    color: #a361dc;
    margin: 0 0 10px 0;
    text-shadow: 0 2px 4px rgba(163, 97, 220, 0.1);
}

.login-subtitle {
    font-size: 18px;
    font-weight: 500;
    color: #666;
    margin: 0;
    opacity: 0.8;
}

.login-form {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.login-select,
.login-input {
    width: 100%;
}

.login-select :deep(.el-input__wrapper) {
    background: rgba(163, 97, 220, 0.05);
    border: 2px solid rgba(163, 97, 220, 0.1);
    border-radius: 12px;
    transition: all 0.3s ease;
}

.login-select :deep(.el-input__wrapper:hover) {
    border-color: rgba(163, 97, 220, 0.3);
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.1);
}

.login-select :deep(.el-input__wrapper.is-focus) {
    border-color: #a361dc;
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.2);
}

.login-input :deep(.el-input__wrapper) {
    background: rgba(163, 97, 220, 0.05);
    border: 2px solid rgba(163, 97, 220, 0.1);
    border-radius: 12px;
    transition: all 0.3s ease;
}

.login-input :deep(.el-input__wrapper:hover) {
    border-color: rgba(163, 97, 220, 0.3);
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.1);
}

.login-input :deep(.el-input__wrapper.is-focus) {
    border-color: #a361dc;
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.2);
}

.login-input :deep(.el-input__inner) {
    color: #333;
    font-weight: 500;
}

.login-input :deep(.el-input__prefix) {
    color: #a361dc;
}

.login-button {
    width: 100%;
    height: 48px;
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    border: none;
    border-radius: 12px;
    font-size: 16px;
    font-weight: 600;
    color: white;
    transition: all 0.3s ease;
    margin-top: 10px;
}

.login-button:hover {
    background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(163, 97, 220, 0.4);
}

.login-button:active {
    transform: translateY(0);
}

.password-hint {
    text-align: center;
    margin-top: 10px;
}

.hint-text {
    color: #666;
    font-size: 14px;
}

.forgot-password {
    text-align: center;
    margin-top: 15px;
}

.forgot-link {
    color: #a361dc;
    font-size: 14px;
    text-decoration: none;
    transition: color 0.3s ease;
}

.forgot-link:hover {
    color: #8b5cf6;
    text-decoration: underline;
}

/* 忘记密码对话框样式 */
.forgot-password-dialog :deep(.el-dialog) {
    border-radius: 36px;
    overflow: hidden;
}

.forgot-password-dialog :deep(.el-dialog__header) {
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    color: white;
    padding: 20px 24px;
}

.forgot-password-dialog :deep(.el-dialog__title) {
    color: white;
    font-weight: 600;
}

.forgot-password-dialog :deep(.el-dialog__body) {
    padding: 30px 24px;
}

.forgot-password-dialog :deep(.el-dialog__footer) {
    padding: 20px 24px;
    border-top: 1px solid #f0f0f0;
}

.forgot-password-steps {
    min-height: 200px;
}

.step-content {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.step-title {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 16px;
    font-weight: 600;
    color: #333;
    margin-bottom: 10px;
}

.step-icon {
    color: #a361dc;
    font-size: 18px;
}

.forgot-select,
.forgot-input {
    width: 100%;
}

.forgot-select :deep(.el-input__wrapper),
.forgot-input :deep(.el-input__wrapper) {
    background: rgba(163, 97, 220, 0.05);
    border: 2px solid rgba(163, 97, 220, 0.1);
    border-radius: 12px;
    transition: all 0.3s ease;
}

.forgot-select :deep(.el-input__wrapper:hover),
.forgot-input :deep(.el-input__wrapper:hover) {
    border-color: rgba(163, 97, 220, 0.3);
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.1);
}

.forgot-select :deep(.el-input__wrapper.is-focus),
.forgot-input :deep(.el-input__wrapper.is-focus) {
    border-color: #a361dc;
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.2);
}

.question-box {
    background: rgba(163, 97, 220, 0.05);
    border: 2px solid rgba(163, 97, 220, 0.1);
    border-radius: 12px;
    padding: 20px;
}

.question-text {
    font-size: 16px;
    font-weight: 500;
    color: #333;
    margin: 0 0 15px 0;
    text-align: center;
}

.dialog-footer {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
}

/* 响应式设计 */
@media (max-width: 768px) {
    .login-box {
        width: 90%;
        max-width: 350px;
        padding: 30px 25px;
    }

    .system-title {
        font-size: 24px;
    }

    .login-subtitle {
        font-size: 16px;
    }

    .forgot-password-dialog :deep(.el-dialog) {
        width: 90% !important;
        max-width: 400px;
    }
}
</style>
