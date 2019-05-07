import consumer from "./consumer"

consumer.subscriptions.create({ channel: "SolverChannel" }, {

  received(data) {
    var cell = "#cell-" + data["index"];
    $(cell).text(data["value"]);
  }

})
