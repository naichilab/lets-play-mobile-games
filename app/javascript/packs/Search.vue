<template>
    <div>
        <div v-for="category in categories">
            <input type="checkbox" :id="'chk' + category.id" :value="category.id"
                   v-model="form_values.checkedCategories" v-on:change="getGames">
            <label :for="'chk' + category.id" v-text="category.name"></label>
        </div>
        {{form_values.checkedCategories}}

        <button @click="getGames()">get</button>
        <ul>
            <li v-for="game in games">
                {{ game.title }}
            </li>
        </ul>
    </div>
</template>
<script>
    import axios from 'axios';

    export default {
        data: function () {
            return {
                games: {},
                categories: {},
                form_values: {
                    checkedCategories: []
                }
            }
        },
        created: function () {
            axios.get('/api/categories')
                .then(res => {
                    this.categories = res.data
                })
        },
        methods: {
            getGames() {
                let queries = '?'
                this.form_values.checkedCategories.forEach((v,i,a)=>{
                    queries += 'categories[]=' + v + '&'
                })
                var url = '/api/games'
                if(queries.length > 1){
                    url += queries
                }
                axios.get(url)
                    .then(res => {
                        this.games = res.data;
                    });
            }
        }

    }
</script>
<style scoped>
    p {
        font-size: 2em;
        text-align: center;
    }
</style>