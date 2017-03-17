<spa>
    <nav class="pure-g top-menu">
        <div each="{tab, i in menuTab}" class="pure-u-1-3 {top-menu-selected: parent.isActiveTab(tab.ref)}">
            <a href="#{tab.ref}"><img src="./img/{tab.ref}.svg"/></a>
        </div>
    </nav>

    <div class="pure-g">
        <div class="pure-u-1-1 {hidden: !isActiveTab('magie')}">
            <list-magie></list-magie>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('detail-magie')}">
            <detail-magie></detail-magie>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('kabbale')}">
            <list-kabbale></list-kabbale>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('detail-kabbale')}">
            <detail-kabbale></detail-kabbale>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('alchimie')}">
            <list-alchimie></list-alchimie>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('detail-alchimie')}">
            <detail-alchimie></detail-alchimie>
        </div>
    </div>
    <script>
        this.menuTab = [
            {ref: 'magie', title: 'icon-heka'},
            {ref: 'kabbale', title: 'icon-kabbale'},
            {ref: 'alchimie', title: 'icon-alchimie'}
        ]
        this.activeTab = 'kabbale'

        isActiveTab(ref) {
            return ref === this.activeTab
        }

        // this to hide waiting spinner
        this.on('mount', function() {
        document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
        })

        var subRoute = riot.route.create()
        var self = this
        this.menuTab.forEach(function(tab) {
            subRoute('/' + tab.ref, function() {
                self.activeTab = tab.ref
                self.update()
            })
        })
    </script>
</spa>