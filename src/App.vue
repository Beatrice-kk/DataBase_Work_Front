<template>
  <router-view></router-view>
</template>

<script>

export default { 
  name: 'App',
  mounted() {
    document.title = '学生成绩管理系统'
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
