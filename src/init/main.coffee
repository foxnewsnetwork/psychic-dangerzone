###########################
# Public Static Void Main #
###########################

PublicStaticVoidMain: ->
	hashname = window.location.hash
	pathname = window.location.pathname
	gamestate = new GameState({hash: hashname, path: pathname})
	app = new App(gamestate)

$ PublicStaticVoidMain()

