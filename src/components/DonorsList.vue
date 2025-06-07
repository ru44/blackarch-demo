<script setup>
import { ref, onMounted } from 'vue'
import donorsJson from '../data/donors.json'
import DataTable from './DataTable.vue'

const donors = ref([])
const isLoading = ref(true)

onMounted(() => {
  donors.value = donorsJson
  isLoading.value = false
})

const columns = [
  { key: 'name', label: 'Name' },
  { key: 'amount', label: 'Amount' },
  { key: 'date', label: 'Date' },
  { key: 'website', label: 'Website', type: 'link' }
]
</script>

<template>
  <DataTable
    title="BlackArch Donors"
    :data="donors"
    :columns="columns"
    :isLoading="isLoading"
  />
</template>