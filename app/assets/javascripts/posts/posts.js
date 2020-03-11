$(document).on("turbolinks:load", () =>{
    if (!(context.has_controller("posts") && context.has_action("index"))) return;
    $(".comment_button").on("click",() => {
        

        let b = $(event.target);
        let id = b.data('id');
        let currentPost = $(`#post_${id}`);

        function ajaxRequest(node, is_form){
            console.log(node);
            $.ajax({
                url: "posts/show_comment_form",
                type: "get",
                data: {id: id, form: is_form},
                success: (data, status, xhr) => {
                    node.html(data.data);
                }
            });
        }

        let cs = currentPost.find(".comments_section");
        let c = currentPost.find(".comments");
        let a = currentPost.find(".add_comment_button");
        
        console.log(cs);
        cs.toggleClass("js_visible");
        console.log(b.data('comments'));
        if (cs.hasClass("js_visible")){
            a.html("<button>Add comment</button>");
            if (b.data('comments')){
                ajaxRequest(c, false);
            } else {
                c.html("No Comments!")
            }
            b.val("Hide Comments");
            cs.slideDown();
        } else {
            cs.slideUp();
            b.val("View Comments");
        }

        currentPost.find(".add_comment_button button").on("click",() => {
            
            ajaxRequest(currentPost.find(".comment_form"), true);
            
        });
    });
});
