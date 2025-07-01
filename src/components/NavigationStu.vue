<template>
    <el-container class="layout-container-demo" style="height: 500px">
        <el-aside width="200px">
            <el-scrollbar>
                <el-menu :default-openeds="['1', '2']" id="navMenu" class="el-menu-vertical-demo" @select="handleSelect"
                    mode="vertical">
                    <el-menu-item index="0" class="vertical-submenu">
                        <span>首页</span>
                    </el-menu-item>
                    <el-sub-menu index="1" class="vertical-submenu">
                        <template #title>
                            <span>查询</span>
                        </template>
                        <template class="vertical-submenu">
                            <el-menu-item index="1-1">&emsp;课程成绩查询</el-menu-item>
                            <el-menu-item index="1-2">&emsp;学年成绩查询</el-menu-item>
                            <el-menu-item index="1-3">&emsp;所学课程查询</el-menu-item>
                            <el-menu-item index="1-4">&emsp;班级开设课程查询</el-menu-item>
                        </template>
                    </el-sub-menu>
                </el-menu>
            </el-scrollbar>
        </el-aside>
        <el-container class="subconter">
            <el-header style="text-align: right; font-size: 12px">
                <el-row type="flex" justify="space-between">
                    <p class="title">学生成绩管理系统</p>
                    <el-button class="titlebut" type="primary" round @click="exit">退出登录</el-button>
                </el-row>
            </el-header>
            <el-main>
                <slot></slot>
            </el-main>
        </el-container>
    </el-container>
</template>

<script>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

export default {
    name: 'NavigationStu',
    setup() {
        const router = useRouter();
        const UserOccupation1 = ref(true);
        const UserOccupation2 = ref(false);

        const handleSelect = (index) => {
            if (index === '0') {
                router.push('/student/home');
            } else if (index === '1-1') {
                router.push('/student/stuscore');
            } else if (index === '1-2') {
                router.push('/student/stuscoreyear');
            } else if (index === '1-3') {
                router.push('/student/stusearchclass');
            } else if (index === '1-4') {
                router.push('/student/stureadclass');
            }

        };

        const exit = () => {
            sessionStorage.setItem("Authorization", " ");
            sessionStorage.setItem("user_id", 0);
            sessionStorage.setItem("occupation", "");
            router.push("/");
        };

        if (sessionStorage.getItem('occupation') === 'manger_g' || sessionStorage.getItem('occupation') === 'cto') {
            UserOccupation1.value = false;
            UserOccupation2.value = true;
        } else if (sessionStorage.getItem('occupation') === 'big_manger') {
            UserOccupation1.value = true;
            UserOccupation2.value = false;
        }

        return {
            UserOccupation1,
            UserOccupation2,
            handleSelect,
            exit
        };
    }
};
</script>

<style scoped>
.layout-container-demo {
    height: 100vh;
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
}

.layout-container-demo .el-header {
    background: linear-gradient(135deg, #A361DC 0%, #8B5CF6 100%);
    color: white;
    box-shadow: 0 4px 20px rgba(163, 97, 220, 0.2);
    padding: 0 30px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.layout-container-demo .el-aside {
    background: white;
    border-right: 1px solid rgba(163, 97, 220, 0.1);
    padding-top: 0;
    box-shadow: 4px 0 20px rgba(163, 97, 220, 0.1);
}

.layout-container-demo .el-menu {
    border-right: none;
    background-color: transparent;
    padding: 20px 0;
}

.layout-container-demo .el-menu :deep(.el-menu-item) {
    border-radius: 12px;
    margin: 4px 12px;
    transition: all 0.3s ease;
    color: #666;
    font-weight: 500;
    height: 48px;
    line-height: 48px;
}

.layout-container-demo .el-menu :deep(.el-menu-item:hover) {
    background: linear-gradient(135deg, rgba(163, 97, 220, 0.1) 0%, rgba(139, 92, 246, 0.1) 100%);
    color: #A361DC;
    transform: translateX(5px);
}

.layout-container-demo .el-menu :deep(.el-menu-item.is-active) {
    background: linear-gradient(135deg, #A361DC 0%, #8B5CF6 100%);
    color: white;
    box-shadow: 0 4px 15px rgba(163, 97, 220, 0.3);
}

.layout-container-demo .el-menu :deep(.el-sub-menu__title) {
    border-radius: 12px;
    margin: 4px 12px;
    transition: all 0.3s ease;
    color: #666;
    font-weight: 600;
    height: 48px;
    line-height: 48px;
}

.layout-container-demo .el-menu :deep(.el-sub-menu__title:hover) {
    background: linear-gradient(135deg, rgba(163, 97, 220, 0.1) 0%, rgba(139, 92, 246, 0.1) 100%);
    color: #A361DC;
}

.layout-container-demo .el-menu :deep(.el-sub-menu.is-active .el-sub-menu__title) {
    color: #A361DC;
    background: rgba(163, 97, 220, 0.05);
}

.layout-container-demo .el-menu :deep(.el-sub-menu .el-menu-item) {
    margin-left: 20px;
    margin-right: 12px;
    border-radius: 8px;
    height: 40px;
    line-height: 40px;
    font-size: 14px;
}

.layout-container-demo .el-menu :deep(.el-sub-menu .el-menu-item:hover) {
    background: linear-gradient(135deg, rgba(163, 97, 220, 0.1) 0%, rgba(139, 92, 246, 0.1) 100%);
    color: #A361DC;
    transform: translateX(3px);
}

.layout-container-demo .el-menu :deep(.el-sub-menu .el-menu-item.is-active) {
    background: linear-gradient(135deg, #A361DC 0%, #8B5CF6 100%);
    color: white;
    box-shadow: 0 2px 10px rgba(163, 97, 220, 0.3);
}

.layout-container-demo .el-main {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    padding: 20px;
    overflow-y: auto;
}

.layout-container-demo .toolbar {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 100%;
    right: 20px;
}

.vertical-submenu {
    display: flex;
    flex-direction: column;
}

.el-menu-vertical-demo {
    display: flex;
    flex-direction: column;
    background: transparent;
}

.el-aside {
    height: 100vh;
    box-shadow: 4px 0 20px rgba(163, 97, 220, 0.1);
}

.subconter {
    height: 100vh;
    overflow: hidden;
    background: transparent;
}

.title {
    font-size: 24px;
    color: white;
    margin: 0;
    line-height: 60px;
    font-weight: 700;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.titlebut {
    font-size: 14px;
    height: 36px;
    margin-top: 12px;
    background: rgba(255, 255, 255, 0.2);
    border: 1px solid rgba(255, 255, 255, 0.3);
    color: white;
    border-radius: 18px;
    transition: all 0.3s ease;
    font-weight: 600;
}

.titlebut:hover {
    background: rgba(255, 255, 255, 0.3);
    border-color: rgba(255, 255, 255, 0.5);
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

/* 滚动条样式 */
.layout-container-demo :deep(.el-scrollbar__bar) {
    background: rgba(163, 97, 220, 0.1);
}

.layout-container-demo :deep(.el-scrollbar__thumb) {
    background: rgba(163, 97, 220, 0.3);
    border-radius: 4px;
}

.layout-container-demo :deep(.el-scrollbar__thumb:hover) {
    background: rgba(163, 97, 220, 0.5);
}

/* 响应式设计 */
@media (max-width: 768px) {
    .layout-container-demo .el-aside {
        width: 180px !important;
    }
    
    .title {
        font-size: 20px;
    }
    
    .layout-container-demo .el-header {
        padding: 0 15px;
    }
}
</style>