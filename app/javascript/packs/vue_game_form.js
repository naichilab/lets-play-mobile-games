/* eslint no-console: 0 */
import Vue from 'vue/dist/vue.esm'
import VueDataScooper from "vue-data-scooper"

// import game_form from './game_form.vue'
//
// Vue.component('game-form', game_form)

Vue.use(VueDataScooper)

document.addEventListener("DOMContentLoaded", () => {
    new Vue({
        el: "#game-form",
        methods: {
            showHoge() {
                console.log("this is hogehoge")
            }
        },
    })
})
