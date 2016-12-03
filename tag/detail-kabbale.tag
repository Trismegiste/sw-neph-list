<detail-kabbale>
    <article>
        <header>{model.Sort}</header>
        <div  class="pure-g">
            <div class="pure-u-1-3">{model.Cercle}</div>
            <div class="pure-u-1-3">{model.Monde}</div>
            <div class="pure-u-1-3">{model.Element}</div>
            <div class="pure-u-1-3">Ka: {model.Ka}</div>
            <div class="pure-u-1-3">{model['Portée']}</div>
            <div class="pure-u-1-3">{model['Durée']}</div>
            <div class="pure-u-1-1"><section>{model.Effet}</section></div>
            <div class="pure-u-1-1"><section>{model.Aspect}</section></div>
        </div>
    </article>
    <script>
        this.kabbaleList = nephData.get('kabbale')
        this.model = {}
        var self = this

        var subRoute = riot.route.create()
        subRoute('/kabbale/*', function (pk) {
            self.parent.activeTab = 'detail-kabbale'
            self.model = self.kabbaleList[pk]
            self.parent.update()
        })
    </script>
</detail-kabbale>