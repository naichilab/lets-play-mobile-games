/* eslint no-console: 0 */
import Vue from 'vue/dist/vue.esm'
import game_form from './game_form.vue'

Vue.component('game-form', game_form)
const app = new Vue({
    el: '#vue'
})
