/* eslint no-console: 0 */
import Vue from 'vue/dist/vue.esm'
import game_search from './game_search.vue'

Vue.component('game-search', game_search)
const app = new Vue({
    el: '#vue'
})
