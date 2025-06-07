---
outline: false
title: Tools
---

<script setup>
import { ref } from 'vue'
import ToolsList from './components/ToolsList.vue'

const totalTools = ref(0)
</script>

# Hacking Tools List

Every package of the BlackArch Linux repository is listed in the following table.
If you don't find your needed tool in this list simply open an <a href="https://github.com/BlackArch/blackarch/issues/new">issue</a> or better do a <a href="https://github.com/BlackArch/blackarch/pulls">pull request</a> for the tool you want to be in our repository.
We are fast at packaging and releasing tools.

<b>Total Tools:</b> {{ totalTools }}

<ToolsList @update:total="totalTools = $event" />
