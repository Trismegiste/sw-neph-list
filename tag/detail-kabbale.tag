<detail-kabbale>
    <div>detail</div>

    <script>
        var self = this

        var subRoute = riot.route.create()
        subRoute('/kabbale/*', function (pk) {
            self.parent.activeTab = 'detail-kabbale'
            console.log(pk)
            self.parent.update()
        })
    </script>
</detail-kabbale>