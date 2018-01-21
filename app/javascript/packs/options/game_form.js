import InputTag from 'vue-input-tag'

export default {
    data: () => ({
    }),
    components: {
        'input-tag': InputTag
    },
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
        },
        onUploadedFile: function(evt) {
            for (var i = 0, f; f = evt.target.files[i]; i++) {
                if (!f.type.match('image.*')) {
                    continue;
                }
                var reader = new FileReader();
                reader.onload = (function(theFile) {
                    return function(e) {
                        preview_image.style.backgroundImage = ['url(', e.target.result, ')'].join('');
                    };
                })(f);
                reader.readAsDataURL(f);
            }
        }
    },
}
