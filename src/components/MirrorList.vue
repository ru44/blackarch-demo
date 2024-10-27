<script setup>
import mirrors from '../data/mirrors.json'
</script>

<template>
    <div>
        <h2 id="official-blackarch-linux-mirror-sites">Official BlackArch Linux Mirror Sites</h2>
        <div v-for="(urls, country) in mirrors" :key="country">
            <h3>{{ country }}</h3>
            <ul>
                <li v-for="url in urls" :key="url">
                    <a :href="url" target="_blank" rel="noopener noreferrer">{{ url }}</a>
                </li>
            </ul>
        </div>
    </div>
</template>

<style scoped>
h3 {
    margin-top: 1.5em;
}

ul {
    padding-left: 1.5em;
}

li {
    margin-bottom: 0.5em;
}
</style>
