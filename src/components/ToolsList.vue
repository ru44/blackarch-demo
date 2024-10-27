<script setup>
import { ref, onMounted, watch } from 'vue'

const emit = defineEmits(['update:total'])

const tools = ref([])
const filteredTools = ref([])
const searchInput = ref('')
const isLoading = ref(true)

const modules = import.meta.glob('../data/tools/*.json')

watch(searchInput, search)

watch(filteredTools, () => {
    emit('update:total', tools.value.length)
})

onMounted(async () => {
    const allData = await Promise.all(
        Object.values(modules).map(async (load) => {
            const json = await load()
            return Array.isArray(json.default) ? json.default : [json.default]
        })
    )

    const flatData = allData.flat()
    const deduped = Array.from(
        new Map(flatData.map(tool => [tool.name, tool])).values()
    )

    tools.value = deduped
    filteredTools.value = deduped
    isLoading.value = false
    emit('update:total', deduped.length)
})

function search() {
    const query = searchInput.value.toLowerCase()
    filteredTools.value = tools.value.filter(tool =>
        tool.name.toLowerCase().includes(query)
    )
}
</script>

<template>
    <div>
        <label class="label">
            Filtered Tools: {{ filteredTools.length }}
        </label>

        <div class="search-wrapper">
            <input v-model="searchInput" placeholder="Search tools..." class="input" @keydown.enter="search" />
            <button @click="search" class="button">Search</button>
        </div>

        <div class="table-wrapper">
            <table v-if="filteredTools.length" class="tools-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Version</th>
                        <th>Description</th>
                        <th>Website</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="tool in filteredTools" :key="tool.name">
                        <td data-label="Name">{{ tool.name }}</td>
                        <td data-label="Version">{{ tool.version }}</td>
                        <td data-label="Description">{{ tool.description }}</td>
                        <td data-label="Website">
                            <a :href="tool.url" target="_blank" rel="noopener noreferrer">Link</a>
                        </td>
                    </tr>
                </tbody>
            </table>

            <div v-else-if="isLoading" class="spinner"></div>
            <p v-else>No tools found.</p>
        </div>
    </div>
</template>


<style scoped>
.label {
    display: block;
    margin-bottom: 0.5rem;
    font-size: 0.875rem;
    font-weight: 500;
    color: #babfc7;
}

.search-wrapper {
    display: flex;
    gap: 0.5rem;
    margin-bottom: 1rem;
}

.input {
    flex-grow: 1;
    min-width: 0;
    border-radius: 0.5rem 0 0 0.5rem;
    border-right: none;
}

.button {
    border-radius: 0 0.5rem 0.5rem 0;
    border-left: none;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.input,
.button {
    height: 2.5rem;
    font-size: 1rem;
    padding-left: 1rem;
    padding-right: 1rem;
    border: 1px solid #d1d5db;
}

.button:hover {
    background-color: #1d4ed8;
    color: white;
}

.input:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 1px #3b82f6;
    border-right: none;
}

@media (prefers-color-scheme: dark) {
    .input {
        background-color: #374151;
        border-color: #4b5563;
        color: #ffffff;
        border-right: none;
    }

    .input::placeholder {
        color: #9ca3af;
    }

    .input:focus {
        border-color: #3b82f6;
        box-shadow: 0 0 0 1px #3b82f6;
    }

    .button {
        border-left: none;
    }
}

.tools-table {
    width: fit-content;
}

.tools-table th,
.tools-table td {
    padding: 8px;
    vertical-align: top;
    text-align: left;
    border-bottom: 1px solid #e5e7eb;
}

.tools-table th {
    position: sticky;
    top: 0;
    background-color: #f3f4f6;
    z-index: 1;
    font-weight: bold;
}

@media (prefers-color-scheme: dark) {
    .tools-table th {
        background-color: #1f2937;
        color: #ffffff;
    }
}

/* Narrow columns on desktop */
.tools-table th:nth-child(1),
.tools-table td:nth-child(1),
.tools-table th:nth-child(2),
.tools-table td:nth-child(2) {
    width: 5%;
    font-size: 0.9em;
    white-space: nowrap;
}

.tools-table th:nth-child(3),
.tools-table td:nth-child(3) {
    width: 60%;
    font-size: 1em;
}

.tools-table th:nth-child(4),
.tools-table td:nth-child(4) {
    width: 30%;
    font-size: 0.9em;
}

/* Loading spinner */
.spinner {
    margin: 2rem auto;
    width: 3rem;
    height: 3rem;
    border: 5px solid #d1d5db;
    border-top-color: #1d4ed8;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    to {
        transform: rotate(360deg);
    }
}

/* Responsive Mobile: Stack rows, no horizontal scroll */
@media (max-width: 640px) {

    .tools-table,
    .tools-table thead,
    .tools-table tbody,
    .tools-table th,
    .tools-table td,
    .tools-table tr {
        display: block;
        width: 100%;
    }

    /* Hide header row on mobile */
    .tools-table thead tr {
        position: absolute;
        top: -9999px;
        left: -9999px;
    }

    .tools-table tr {
        margin-bottom: 1.5rem;
        border: 1px solid #ddd;
        border-radius: 0.5rem;
        padding: 1rem;
        background: #fafafa;
    }

    .tools-table tr:nth-child(even) {
        background: #f0f0f0;
    }

    .tools-table td {
        border: none;
        padding-left: 50%;
        position: relative;
        text-align: left;
        font-size: 0.9em;
    }

    .tools-table td::before {
        position: absolute;
        top: 50%;
        left: 1rem;
        width: 45%;
        padding-right: 1rem;
        white-space: nowrap;
        font-weight: 600;
        transform: translateY(-50%);
        content: attr(data-label);
    }

    /* Adjust colors for dark mode on mobile */
    @media (prefers-color-scheme: dark) {
        .tools-table tr {
            background: #1e293b;
            border-color: #334155;
        }

        .tools-table tr:nth-child(even) {
            background: #273449;
        }

        .tools-table td {
            color: #d1d5db;
        }

        .tools-table td::before {
            color: #9ca3af;
        }
    }
}

/* Spinner */
.spinner {
    margin: 2rem auto;
    width: 3rem;
    height: 3rem;
    border: 5px solid #d1d5db;
    border-top-color: #1d4ed8;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    to {
        transform: rotate(360deg);
    }
}

/* Mobile tweaks */
@media (max-width: 640px) {

    .input,
    .button {
        font-size: 0.9rem;
        padding-left: 0.75rem;
        padding-right: 0.75rem;
    }

    .tools-table th,
    .tools-table td {
        font-size: 0.85em;
    }
}
</style>