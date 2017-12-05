<template>
    <div>
        <p>
            <select v-model="checkedNames" multiple>
                <option v-for="category in categories">{{category.name}}</option>
            </select>
            <br>
            {{checkedNames}}
        </p>
        <input type=checkbox v-for="category in categories" id="{{ category.id }}" value="{{ category.id }}" v-text="{{category.name}}" v-model="checkedNames">

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
                checkedNames: [],
                games: {},
                categories: {}
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
                var url = '/api/games'
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