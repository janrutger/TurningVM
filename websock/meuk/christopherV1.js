function connect()
  {
    var url = "ws://0.0.0.0:8001/";
    console.log("Opening websocket " + url + "\n");
    websock = new WebSocket(url);
    websock.onopen    = function(evt) {sock_open(evt)};
    websock.onclose   = function(evt) {sock_close(evt)};
    websock.onmessage = function(evt) {sock_message(evt)};
    websock.onerror   = function(evt) {sock_error(evt)};
    connected = true;
    
  }

function register(){
    register = {"register" : webclient}
    websock.send(JSON.stringify(register));
}


// Display incoming data
function sock_message(evt)
    {
        // console.log(evt.data);
        console.log(evt.data)
        input = JSON.parse(evt.data)
        console.log(input)
        if (input["tapeUpdate"]) {
            console.log("received tape update\n")

            document.getElementById("STleft").innerHTML  = input["tapeUpdate"]["ST"][0].slice(-70)
            document.getElementById("SThead").innerHTML  = input["tapeUpdate"]["ST"][1]
            document.getElementById("STright").innerHTML = input["tapeUpdate"]["ST"][2].slice(0, 50)

            document.getElementById("RAleft").innerHTML  = input["tapeUpdate"]["RA"][0].slice(-70)
            document.getElementById("RAhead").innerHTML  = input["tapeUpdate"]["RA"][1]
            document.getElementById("RAright").innerHTML = input["tapeUpdate"]["RA"][2].slice(0, 50)

            document.getElementById("RBleft").innerHTML  = input["tapeUpdate"]["RB"][0].slice(-70)
            document.getElementById("RBhead").innerHTML  = input["tapeUpdate"]["RB"][1]
            document.getElementById("RBright").innerHTML = input["tapeUpdate"]["RB"][2].slice(0, 50)

            document.getElementById("Sleft").innerHTML  = input["tapeUpdate"]["S"][0].slice(-70)
            document.getElementById("Shead").innerHTML  = input["tapeUpdate"]["S"][1]
            document.getElementById("Sright").innerHTML = input["tapeUpdate"]["S"][2].slice(0, 50)
        } else {
            console.log("received other or wrong messagetype\n");
        }
    }

function sock_open(evt)
    {
        console.log("Connected\n");
    }

function sock_close(evt)
    {
       console.log("\nDisconnected\n");
    }

  function sock_error(evt)
    {
        console.log("Socket error\n");
        websock.close();
    }

  window.addEventListener("load", connect, false);

