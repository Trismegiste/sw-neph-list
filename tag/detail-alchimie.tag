<detail-alchimie class="detail pure-g">
    <div class="pure-u-xl-1-3"></div>
    <div class="pure-u-1 pure-u-xl-1-3">
        <article if="{model !== undefined }">
            <header>
                <h1>{model.Sort}</h1>
                <div  class="pure-g big-icon">
                    <div class="pure-u-1-3">
                        <i class="icon-{nephData.extractAlchemyIcon(model)}"></i>
                        <h2>{nephData.extractAlchemyName(model.Cercle)}</h2>
                    </div>
                    <div class="pure-u-1-3">
                        <i class="icon-{model.Substance.toLowerCase()}"></i>
                        <h2>{model.Substance}</h2>
                    </div>
                    <div class="pure-u-1-3">
                        <i class="icon-{model.Element.toLowerCase()}"></i>
                        <h2>{model.Element}</h2>
                    </div>
                </div>
                <div  class="pure-g">
                    <div class="pure-u-1-2">
                        <h3>Portée</h3>
                        {model['Portée']}
                    </div>
                    <div class="pure-u-1-2">
                        <h3>Durée</h3>
                        {model['Durée']}
                    </div>
                </div>
            </header>
            <section>{model.Effet}</section>
            <section>{model.Aspect}</section>
            <footer>page {model.Page}</footer>
        </article>
    </div>
    <script>
        this.listing = nephData.get('alchimie')
        var self = this

        var subRoute = riot.route.create()
        subRoute('/alchimie/*', function (pk) {
            self.parent.activeTab = 'detail-alchimie'
            self.model = self.listing[pk]
            self.parent.update()
        })

    </script>
</detail-alchimie>