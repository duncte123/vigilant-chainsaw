let token = "";

function submitForm() {
    //clear the messages paragraph
    _("messages").innerHTML = "Sending.....";

    if(token == "") {
        _("messages").innerHTML = "Please complete the captcha.";
    }

    //Get all the things
    let fname = _("fname").value,
        lname = _("lname").value,
        email = _("email").value,
        website = _("website").value,
        message = _("message").value;

    // noinspection EqualityComparisonWithCoercionJS
    let flag = fname == "" || lname == "" || email == "" || message == "";

    if(flag) {
        _("messages").innerHTML = "Please fill out all required fields";
        return;
    }

    //Replace all characters that we don't want in our db
    fname = fname.replace(/[^0-9a-z]/gi, "");
    lname = lname.replace(/[^0-9a-z]/gi, "");
    email = email.replace(/[^0-9a-z.@]/gi, "");
    message = message.replace(/[^0-9a-z ]/gi, "");

    let data = new FormData();
    data.append("fname", fname);
    data.append("lname", lname);
    data.append("email", email);
    data.append("message", message);
    data.append("g-recaptcha-response", token);

    // noinspection EqualityComparisonWithCoercionJS
    if(website != "") {
        website = website.replace(/[^a-z0-9\/\\:+*\-_.]/gi, "");
        data.append("website", website);
    }

    const ajax = new XMLHttpRequest();
    ajax.open("POST", "/parsers/form_parser.php");
    ajax.onreadystatechange = ev => {
        console.log(ev);
        // These comments are here just to make my ide stop complaining
        // noinspection EqualityComparisonWithCoercionJS
        if(ajax.readyState == 4 && ajax.status == 200 ) {
            // noinspection EqualityComparisonWithCoercionJS
            if(ajax.responseText == "success") {
                _("cont").innerHTML = "<h4 class='center'>Thanks for your message</h4>"
            } else {
                _("messages").innerHTML = "Something went wrong: " + ajax.responseText;
            }
        } else {
            _("messages").innerHTML = "Something went wrong, try again later.";
        }
    };

    ajax.send(data);
}

function getToken(t) {
    token = t;
}

function _(el) { return document.getElementById(el); }

/**
 * This function turns every * in the form element red.
 * Just because ICBA to do it with html
 */
$(document).ready(() => {
    let form = _("form");
    let form_content = form.innerHTML;
    form.innerHTML = form_content.replace(/\*/g, "<span class=\"star\">*</span>");
});