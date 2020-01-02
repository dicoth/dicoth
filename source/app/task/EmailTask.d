module app.task.EmailTask;

import app.lib.Functions;
import hunt.framework.task.Task;

class EmailTask : Task
{
    this(string touser, string body, string subject)
    {
        _touser = touser;
        _body = body;
        _subject = subject;
    }

    override void exec()
    {
        sendMailCode(_touser, _body, _subject);
    }

    private
    {
        string _touser;
        string _body;
        string _subject;
    }
}
