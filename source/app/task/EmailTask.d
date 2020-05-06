module app.task.EmailTask;

import app.util.Functions;
import hunt.util.Common;

class EmailTask : Runnable {

    this(string touser, string body, string subject) {
        _touser = touser;
        _body = body;
        _subject = subject;
    }

    void run() {
        sendMailCode(_touser, _body, _subject);
    }

    private {
        string _touser;
        string _body;
        string _subject;
    }
}
