export default {
    data: () => ({
    }),
    methods: {
        addUrl() {
            this.store_urls.push({
                "id": undefined,
                "url": undefined,
                "memo": undefined,
                "platform": {
                    "id": undefined,
                    "name": ""
                }
            });
            console.log("add")
        },
        removeUrl(index) {
            this.store_urls.splice(index, 1);
        }
    },
}