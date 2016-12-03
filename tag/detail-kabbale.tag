<detail-kabbale>
    <article>
        <header>
            <h2>{model.Sort}</h2>
            <div  class="pure-g">
                <div class="pure-u-1-3">{model.Cercle}</div>
                <div class="pure-u-1-3">{model.Monde}</div>
                <div class="pure-u-1-3">{model.Element}</div>
                <div class="pure-u-1-3">Ka: {model.Ka}</div>
                <div class="pure-u-1-3">{model['Portée']}</div>
                <div class="pure-u-1-3">{model['Durée']}</div>
            </div>
        </header>
        <section>{model.Effet}</section>
        <section>{model.Aspect}</section>
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