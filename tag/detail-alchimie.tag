<detail-alchimie>
    <article>
        <header>
            <h2>{model.Sort}</h2>
            <div  class="pure-g">
                <div class="pure-u-1-2">{model.Cercle}</div>
                <div class="pure-u-1-2">
                    {model.Substance} de {model.Element}
                </div>
                <div class="pure-u-1-2">{model['Portée']}</div>
                <div class="pure-u-1-2">{model['Durée']}</div>
            </div>
        </header>
        <section>{model.Effet}</section>
        <section>{model.Aspect}</section>
        <footer>page {model.Page}</footer>
    </article>
    <script>
        this.listing = nephData.get('alchimie')
        this.model = {}
        var self = this

        var subRoute = riot.route.create()
        subRoute('/alchimie/*', function (pk) {
            self.parent.activeTab = 'detail-alchimie'
            self.model = self.listing[pk]
            self.parent.update()
        })
    </script>
</detail-alchimie>