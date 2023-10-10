<script setup>
import { ref, onMounted, computed } from "vue";
import api from "../api";
import moment from 'moment';
import DataTable from "primevue/datatable";

const data = ref([]);
const selectedName = ref(null);
const newName = ref(null);


onMounted(() => {
	api.get("/breakfast")
		.then((resp) => {
			data.value = resp.data;
		})
		.catch((err) => {
			console.log(err);
		});
});

function writeback() {
	api.put("/breakfast", data.value)
		.catch((err) => {
			console.log(err);
		});
}

const hallOfShame = computed(() => {
	const tmp = JSON.parse(JSON.stringify(data.value));
	const now = Date.now();
	for (const entry of tmp) {
		entry.weeks = parseInt((now - Date.parse(entry.last)) / (1000 * 60 * 60 * 24 * 7), 10);
	}
	return tmp.sort((a,b)=>b.weeks - a.weeks)
})


function breakfastIsServed() {
	for (const entry of data.value) {
		if (entry.name === selectedName.value.name) {
			entry.last = moment().format("YYYY-MM-DD");
		}
	}
	selectedName.value = null;
	writeback();
}

function remove() {
	for (const index in data.value) {
		if (data.value[index].name === selectedName.value.name) {
			data.value.splice(index, 1);
		}
	}
	selectedName.value = null;
	writeback();
}

function add() {
	data.value.push({
		name: newName.value,
		last: moment().format("YYYY-MM-DD")
	})
	newName.value = null;
	writeback();
}

</script>

<template>
<Card>
	<template #title>Breakfast Stats</template>
	<template #content>
		<DataTable :value="hallOfShame" >
    		<Column field="name" header="Name">
				<template #body="slotProps">
            		<img v-if="slotProps.index === 0" src="/src/assets/death-star.svg" width="20" height="20" class="mr-2">{{ slotProps.data.name }}
        		</template>
			</Column>
    		<Column field="weeks" header="Weeks since last time"></Column>
		</DataTable>
	</template>
</Card>

<Card>
	<template #content>
		<Dropdown v-model="selectedName" :options="data" optionLabel="name" placeholder="Select a Person" class="w-full md:w-14rem mr-3" />
		<Button label="Breakfast is served!" @click="breakfastIsServed" :disabled="selectedName === null" class="mr-3" />
		<Button label="Remove" @click="remove" :disabled="selectedName === null" class="mr-3"/>
	</template>
</Card>
<Card>
	<template #content>
		<InputText type="text" v-model="newName" placeholder="New Person" class="w-full md:w-14rem mr-3" />
		<Button label="Add" @click="add" :disabled="newName === null" class="mr-3" />
	</template>
</Card>
</template>
