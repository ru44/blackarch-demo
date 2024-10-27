<script setup>
import { ref, onMounted } from 'vue'
import developers from '../data/developers.json'
const isLoading = ref(true)

onMounted(() => {
    developers.value = developers
    isLoading.value = false
})

</script>

<template>
    <div>
        <h2 id="blackarch-linux-developers">BlackArch Developers</h2>
        <p v-if="isLoading">Loading...</p>
        <table v-else>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Nickname</th>
                    <th>Email</th>
                    <th>GPG Key</th>
                    <th>Role</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="developer in developers" :key="developer.name">
                    <td>{{ developer.name }}</td>
                    <td>{{ developer.nickname }}</td>
                    <td>
                        <a href="mailto:{{ developer.email }}">
                            {{ developer.email }}
                        </a>
                    </td>
                    <td>{{ developer.gpg_key }}</td>
                    <td>{{ developer.role }}</td>
                </tr>
            </tbody>
        </table>
        <p v-if="developers.length === 0">No developers found.</p>
    </div>
</template>