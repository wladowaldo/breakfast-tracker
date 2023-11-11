import { createApp } from "vue";
import App from "./App.vue";
import PrimeVue from "primevue/config";
import Button from "primevue/button";
import Card from "primevue/card";
import Column from "primevue/column";
import DataTable from "primevue/datatable";
import Dropdown from "primevue/dropdown";
import InputText from "primevue/inputtext";

import "primevue/resources/themes/nano/theme.css";
import "primevue/resources/primevue.min.css";
import "primeicons/primeicons.css";
import "primeflex/primeflex.css";

createApp(App)
    .use(PrimeVue, {ripple: true})
    .component("Button", Button)
    .component("Card", Card)
    .component("Column", Column)
    .component("DataTable", DataTable)
    .component("Dropdown", Dropdown)
    .component("InputText", InputText)
    .mount("#app");
