<spa>
    <nav class="pure-menu pure-menu-horizontal top-menu">
        <ul class="pure-menu-list">
            <li each="{tab, i in menuTab}"
                class="pure-menu-item {pure-menu-selected: parent.isActiveTab(tab.ref)}">
                <a href="#{tab.ref}" class="pure-menu-link">
                    { tab.title }
                </a>
            </li>
        </ul>
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
            {ref: 'magie', title: 'Magie'},
            {ref: 'kabbale', title: 'Kabbale'},
            {ref: 'alchimie', title: 'Alchimie'}
        ]
        var self = this

        this.isActiveTab = function (ref) {
            return ref === self.activeTab
        }

        var subRoute = riot.route.create()
        this.menuTab.forEach(function (tab) {
            subRoute('/' + tab.ref, function () {
                self.activeTab = tab.ref
                myConfig.write('default', tab.ref)
                self.update()
            })
        })

        // this to hide waiting spinner
        this.on('mount', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
            // first page :
            var defaultRoute = myConfig.read('default', 'magie')
            riot.route(defaultRoute)
        })

    </script>
</spa>