<script setup>
import { ref } from 'vue'
import mirrors from '../data/mirrors.json'

const openStates = ref({})

const toggleDropdown = (country) => {
    openStates.value[country] = !openStates.value[country]
}
</script>

<template>
    <div>
        <h2 id="official-blackarch-linux-mirror-sites">Official BlackArch Linux Mirror Sites</h2>
        <div v-for="(urls, country) in mirrors" :key="country" class="dropdown-container">
            <button class="dropdown-button" @click="toggleDropdown(country)">
                {{ country }}
                <svg :class="['icon', { 'rotated': openStates[country] }]" viewBox="0 0 10 6" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <path d="M1 1L5 5L9 1" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" />
                </svg>
            </button>
            <div v-show="openStates[country]" class="dropdown-menu">
                <ul>
                    <li v-for="url in urls" :key="url">
                        <a :href="url" target="_blank" rel="noopener noreferrer">{{ url }}</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>

<style scoped>
.icon {
    width: 10px;
    height: 10px;
    margin-left: 0.75rem;
    pointer-events: none;
    transition: transform 0.3s ease;
}

.icon.rotated {
    transform: rotate(180deg);
}

.dropdown-container {
    margin-bottom: 1rem;
    position: relative;
}

.dropdown-button {
    background-color: rgb(62, 99, 221);
    color: white;
    padding: 0.625rem 1.25rem;
    font-size: 0.875rem;
    font-weight: 500;
    border: none;
    border-radius: 0.5rem;
    cursor: pointer;
    text-align: left;
    display: inline-flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    transition: background-color 0.2s ease-in-out;
}

.dropdown-button:hover {
    background-color: #1e40af;
}

.dropdown-button:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.5);
}

.icon {
    width: 10px;
    height: 10px;
    margin-left: 0.75rem;
    pointer-events: none;
}

.dropdown-menu {
    position: relative;
    background-color: white;
    border-radius: 0.5rem;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
    margin-top: 0.5rem;
    padding: 0.5rem 0;
    width: 100%;
    z-index: 10;
}

.dropdown-menu ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.dropdown-menu li a {
    display: block;
    padding: 0.5rem 1rem;
    color: #374151;
    text-decoration: none;
    font-size: 0.875rem;
}

.dropdown-menu li a:hover {
    background-color: #f3f4f6;
    color: #111827;
}

@media (prefers-color-scheme: dark) {
    .dropdown-button {
        background-color: rgb(42, 68, 153);
        color: #ffffff;
    }

    .dropdown-button:hover {
        background-color: #1e3a8a;
    }

    .dropdown-menu {
        background-color: #1f2937;
        box-shadow: 0 4px 10px rgba(255, 255, 255, 0.05);
    }

    .dropdown-menu li a {
        color: #d1d5db;
    }

    .dropdown-menu li a:hover {
        background-color: #374151;
        color: #ffffff;
    }
}
</style>
