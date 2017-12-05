<template>
    <div>
        <div v-for="category in masterData.categories">
            <input type="checkbox" :id="'chk' + category.id" :value="category.id"
                   v-model="formValues.categories" v-on:change="getGames">
            <label :for="'chk' + category.id" v-text="category.name"></label>
        </div>
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
                masterData: {
                    categories: {}
                },
                formValues: {
                    categories: []
                }
            }
        },
        created: function () {
            axios.get('/api/categories')
                .then(res => {
                    this.masterData.categories = res.data
                })
        },
        methods: {
            getGames() {
                axios.get('/api/games'
                    , {params: this.formValues})
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