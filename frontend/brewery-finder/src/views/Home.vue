<template>
  <section class="home">
    <the-map v-bind:appData="appData"></the-map>
  </section>
</template>

<script>
// @ is an alias to /src
import TheMap       from "@/components/TheMap.vue"

export default {
  name: "home",
  components: {
    TheMap
  },
  props: {
    appData: Object
  },
};
</script>

<style scoped>

</style>
