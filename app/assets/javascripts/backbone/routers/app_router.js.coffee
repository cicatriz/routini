class Shuff.Routers.AppRouter extends Backbone.Router
  initialize: (options) ->
    @contexts = new Shuff.Collections.Contexts()
    @contexts.reset options.contexts

    # render context chooser 
    view = new Shuff.Views.ContextsChooser(collection: @contexts)
    $('#context-chooser').html(view.render().el)

    view = new Shuff.Views.ContextsChart(collection: @contexts)
    $('#info-panel').prepend(view.render().el)
    #ShuffCharts.renderDaily($('#daily-chart'), view.chartData())

    # render 'all' context if it exists
    @contexts.each((context) ->
      if context.get('name') == 'all'
        context.fetch({
          success: () ->
            view = new Shuff.Views.ContextsShow(model: context)
            $('#all-tasks').html(view.renderColumn().el)
        })
    )


  routes:
    "/contexts/:cid/tasks/:tid" : "showTask",
    "/contexts/:id"             : "showContext"
    #"/contexts"                 : "index"
  
  updateSelectedContext: (id) ->
    $(".context-option").removeClass("selected-context")
    $("#context"+id).addClass("selected-context")

  showContext: (id) ->
    $('#task-panel').hide()
    context = @contexts.get(id)
    context.fetch({
      success: () =>
        view = new Shuff.Views.ContextsShow(model: context)
        $("#context").html(view.render().el)
        view.renderCharts()
        @updateSelectedContext(id)
    })

  showTask: (cid, tid) ->
    $('#task-panel').show()
    context = @contexts.get(cid)
    task = context.tasks.get(tid)
    task.fetch({
      success: () ->
        view = new Shuff.Views.TasksShow(model: task)
        $('#task-panel').html(view.render().el)
        ShuffClock.renderTimer(task.get('time'))
    })

  index: () ->
    #  @contexts.fetch({
    #    success: () =>
    #      $("#context").html("")
    #      $("#task").html("")
    #      view = new Shuff.Views.ContextsIndex(collection: @contexts)
    #      $("#context").html(view.render().el)
    #  })

