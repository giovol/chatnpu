$(document).ready(function () {
    let firstMessageSent = false;

    $('#user-input').keypress(function (event) {
        if (event.which === 13) {
            var userMessage = $('#user-input').val();
            if (userMessage.trim() !== '') {
                $.post('/send_message', { message: userMessage })
                    .done(function (data) {
                        var userMessageElement = $('<p class="input">' + userMessage + '</p>').hide();
                        $('#chat-box').append(userMessageElement);
                        userMessageElement.fadeIn();

                        $('#user-input').val('');

                        if (!firstMessageSent) {
                            $('#chat-title').fadeOut();
                            firstMessageSent = true;
                        }

                        var botResponseElement = $('<p class="output">' + data.response + '</p>').hide();
                        $('#chat-box').append(botResponseElement);
                        botResponseElement.fadeIn();
                    })
                    .fail(function () {
                        var errorMessageElement = $('<p class="output">Error sending message. Please try again.</p>').hide();
                        $('#chat-box').append(errorMessageElement);
                        errorMessageElement.fadeIn();
                    });
            }
        }
    });

    $('#export-button').click(function () {
        window.location.href = '/export_chat'; // Redirect to export route
    });
});