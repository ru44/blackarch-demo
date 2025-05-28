<template>
    <div>
        <img :src="thumbnail" :alt="alt" :width="width" loading="lazy" @click="showModal = true"
            style="cursor: zoom-in; border-radius: 8px; transition: 0.3s" />

        <teleport to="body">
            <div v-if="showModal" class="modal-backdrop" @click="closeModal">
                <img :src="full" :alt="alt" class="modal-image" @click.stop />
            </div>
        </teleport>
    </div>
</template>

<script setup>
import { ref } from 'vue'

const props = defineProps({
    thumbnail: String,
    full: String,
    alt: String,
    width: {
        type: [String, Number],
        default: '400'
    }
})

const showModal = ref(false)

function closeModal() {
    showModal.value = false
}
</script>

<style scoped>
.modal-backdrop {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background-color: rgba(0, 0, 0, 0.85);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 9999;
}

.modal-image {
    max-width: 90vw;
    max-height: 90vh;
    border-radius: 12px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.8);
}
</style>
