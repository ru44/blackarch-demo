<script setup>
import { ref, onMounted } from "vue";
import developers from "../data/donors.json";
const isLoading = ref(true);

onMounted(() => {
  developers.value = developers;
  isLoading.value = false;
});
</script>

<template>
  <div>
    <h2 id="blackarch-linux-donors">BlackArch Donors</h2>
    <p v-if="isLoading">Loading...</p>
    <table v-else>
      <thead>
        <tr>
          <th>Name</th>
          <th>Amount</th>
          <th>Date</th>
          <th>Website</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="donor in developers" :key="donor.name">
          <td>{{ donor.name }}</td>
          <td>{{ donor.amount }}</td>
          <td>{{ donor.date }}</td>
          <td>
            <a v-if="donor.website" :href="donor.website" target="_blank">
              {{ donor.website }}
            </a>
          </td>
        </tr>
      </tbody>
    </table>
    <p v-if="developers.length === 0">No developers found.</p>
  </div>
</template>
