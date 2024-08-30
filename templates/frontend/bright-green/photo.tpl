<script type="text/javascript" src="{$relative_tpl}/js/jquery.comments.js"></script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.voting.js"></script>
<script type="text/javascript" src="{$relative_tpl}/js/jquery.photo.js"></script>

<div class="modal fade" id="shareModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{t c='photo.share'}</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<!-- Go to www.addthis.com/dashboard to customize your tools -->
				<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5e26fd7331f9050b"></script>
                <!-- Go to www.addthis.com/dashboard to customize your tools -->
                <div class="addthis_inline_share_toolbox"></div>   
				<div class="form-group mt-3">
					<label for="photo_share_url">{t c='photo.share_url'}</label>
					<input id="photo_share_url" type="text" class="form-control" value="{$baseurl}/photo/{$photo.PID}" readonly>
					<button class="btn btn-secondary btn-bold mt-1 btn-xs float-right" onclick="copyToClipboard('photo_share_url')"><span id="photo_share_url_copied"><i class="fas fa-clone"></i></span> {translate c='global.copy_to_clipboard'}</button>
					<div class="clearfix"></div>
				</div>					
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-bold float-left" data-dismiss="modal">{translate c='global.cancel'}</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="flagModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{t c='photo.FLAG'}</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>{t c='photo.flag'}</label>
					<div>
						<div class="radio">
							<label>
								<input name="flag_reason" type="radio" value="inappropriate" checked="yes" />
								{t c='flag.inappr'}
							</label>
						</div>
						<div class="radio">
							<label>
								<input name="flag_reason" type="radio" value="underage" />
								{t c='flag.underage'}
							</label>
						</div>
						<div class="radio">
							<label>
								<input name="flag_reason" type="radio" value="copyrighted" />
								{t c='flag.copyright'}
							</label>
						</div>
						<div class="radio">
							<label>
								<input name="flag_reason" type="radio" value="not_playing" />
								{t c='flag.not_playing'}
							</label>
						</div>
						<div class="radio">
							<label>
								<input name="flag_reason" type="radio" value="other" />
								{t c='flag.other'}
							</label>
						</div>
						<div id="flag_reason_error" class="text-danger m-t-5" style="display: none;"></div>
					</div>
				</div>
				<div class="form-group">
					<label for="flag_message">{t c='flag.reason'}</label>
					<div>
						<textarea name="flag_message" class="form-control" rows="3" id="flag_message"></textarea>
					</div>
				</div>				
			</div>
			<div class="modal-footer">
				<button id="submit_flag_photo" data-pid="{$photo.PID}" type="button" class="btn btn-primary btn-bold">{t c='photo.flag'}</button>
				<button type="button" class="btn btn-secondary btn-bold" data-dismiss="modal">{translate c='global.cancel'}</button>
			</div>
		</div>
	</div>
</div>

<div class="container mt-3 mb-3">
	<div class="well-filters">		
		<div class="float-left">
			<h1>{t c='photo.title'}: {$album.name|escape:'html'}</h1>
		</div>
		{if $album.total_photos > 1}
		<div class="float-right well-action">
			<a href="{$relative}/album/slideshow/{$photo.AID}">{t c='global.slideshow'}</a>
		</div>
		{/if}
		<div class="clearfix"></div>
	</div>
	<div class="row">
		<div class="content-left mt-3 mb-3">
			
			<div class="thumb-overlay d-flex justify-content-center">
				{if isset($next)}<a href="{$relative}/photo/{$next}">{/if}<img src="{$relative}/media/photos/{$photo.PID}.jpg" alt="{$photo.caption}" class="img-responsive-mw"/>{if isset($next)}</a>{/if}
			</div>
			<div class="row mt-3">
				<div class="col-12">
					<div class="vote-box float-left">
						<span class="content-rating">
							<span class="mr-2"><i class="fas fa-thumbs-up"></i> <span id="rating_photo_{$photo.PID}">{if $photo.rate != 0}{$photo.rate}%{else}-{/if}</span></span>
							<span class="vote-up mr-1"><i id="vote_up_photo_{$photo.PID}" class="fas fa-thumbs-up"></i> <span id="likes_photo_{$photo.PID}">{$photo.likes}</span></span>			
							<span class="vote-down"><i id="vote_down_photo_{$photo.PID}" class="fas fa-thumbs-down"></i> <span id="dislikes_photo_{$photo.PID}">{$photo.dislikes}</span></span>						
						</span>	
					</div>
					<div class="photo-actions float-right ml-3">
						<a href="#" id="photo_share" class="btn btn-secondary btn-bold btn-xxs"><i class="fas fa-share"></i><span class="d-none d-md-inline"> {t c='global.share'}</span></a>
						{if isset($smarty.session.uid)}
						<a href="#" id="photo_favorite" data-pid="{$photo.PID}" data-aid="{$photo.AID}" class="btn btn-secondary btn-bold btn-xxs"><i class="fas fa-heart"></i><span class="d-none d-md-inline"> {t c='global.favorite'}</span></a>	
						<a href="#" id="photo_flag" data-pid="{$photo.PID}" class="btn btn-secondary btn-bold btn-xxs"><i class="fas fa-flag"></i><span class="d-none d-md-inline"> {t c='global.flag'}</span></a>							
						{/if}

					</div>					
				</div>
			</div>

			<div class="float-left mt-3">
				<a href="{$relative}/album/{$photo.AID}/{$album.name|clean}">{t c='global.back_to'} '{$album.name|escape:'html'}'</a>
			</div>
			<div class="float-right mt-3">
				{if isset($prev)}
					<a href="{$relative}/photo/{$prev}">{t c='global.prev'}</a>
				{/if}
				{if isset($prev) && isset($next)} &middot; {/if}
				{if isset($next)}
					<a href="{$relative}/photo/{$next}">{t c='global.next'}</a>
				{/if}
			</div>
			<div class="clearfix"></div>			

			<div class="row">
				<div class="col-12">
					<div class="card-sub mt-3">
						<div class="float-left">
							<a href="{$relative}/user/{$user.username}"><img class="medium-avatar" src="{$relative}/media/users/{if $user.photo == ''}nopic-{$user.gender}.gif{else}{$user.photo}{/if}" /><span>{$user.username}</span></a>
							{insert name=tsubscribers assign=t_subscribers subscribers=$user.total_subscribers}
							| <span class="total-subscribers" id="total_subscribers">{$t_subscribers}</span>								
						</div>
						<div class="float-right mt-2">
							{if isset($smarty.session.uid) && $smarty.session.uid != $user.UID}
								{insert name=is_subscribed assign=is_subscribed SUID=$smarty.session.uid UID=$user.UID}
								{if isset($is_subscribed) && $is_subscribed}			
									<a href="#" id="user_subscription" data-uid="{$user.UID}" data-subscribed="1" class="btn btn-secondary btn-bold btn-xs ml-2">{t c='user.subscribed'} <i class="fas fa-check"></i></a>
								{else}
									<a href="#" id="user_subscription" data-uid="{$user.UID}" data-subscribed="0" class="btn btn-secondary btn-bold btn-xs ml-2">{t c='user.subscribe'}</a>		
								{/if}
							{/if}							
						</div>						
						<div class="clearfix"></div>
					</div>					
				</div>
			</div>
			{if $photo.caption}
				<div class="mt-3 overflow-hidden">
					{$photo.caption|nl2br}
				</div>
			{/if}			
			{if $photo_comments == '1'}
				<script type="text/javascript">
					var lang_comments_confirm_delete 		= "{t c='comments.delete_confirm'}";
					var lang_comments_reply 		 		= "{t c='global.reply'}";				
					var lang_comments_view_more_replies	 	= "{t c='comments.view_more_replies'}";								
					var lang_comments_insert_media   		= "{t c='comments.insert_media'}";		
					var lang_cancel					   		= "{t c='global.cancel'}";						
				</script>		
				<div class="comments-section mt-3">
					<div class="modal fade" id="commentsMediaModal" tabindex="-1" role="dialog" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-body">
									<nav>
										<div class="nav nav-tabs" role="tablist">
										<a class="nav-item nav-link active" id="nav-cphotos-tab" data-toggle="tab" href="#nav-cphotos" role="tab" aria-controls="nav-cphotos" aria-selected="true">{t c='global.photos'}</a>
										<a class="nav-item nav-link" id="nav-cphotos-tab" data-toggle="tab" href="#nav-cphotos" role="tab" aria-controls="nav-cphotos" aria-selected="false">{t c='global.photos'}</a>
										</div>
									</nav>
									<div class="tab-content">
										<div class="tab-pane fade show active" id="nav-cphotos" role="tabpanel" aria-labelledby="nav-cphotos-tab">
											<input type="text" class="form-control" placeholder="{t c='global.search_photos'}" id="search-cphotos" value="" autocomplete="off">
											<div id="info-cphotos"></div>
											<div class="clearfix"></div>
											<div id="cphotos-container">
											</div>
											<div id="cphotos-loader"><i class="fas fa-circle-notch fa-spin fa-2x"></i></div>
										</div>
										<div class="tab-pane fade" id="nav-cphotos" role="tabpanel" aria-labelledby="nav-cphotos-tab">
											<input type="text" class="form-control" placeholder="{t c='global.search_photos'}" id="search-cphotos" value="" autocomplete="off">
											<div id="info-cphotos"></div>
											<div class="clearfix"></div>
											<div id="cphotos-container">
											</div>
											<div id="cphotos-loader"><i class="fas fa-circle-notch fa-spin fa-2x"></i></div>									
										</div>
									</div>
									<input id="insert_media_target" type="hidden" value="">
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary btn-bold" data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>		
					{assign var="comment_section" value="photo"}
					<div class="well-filters mb-1">
						<div class="float-left mr-3">
							<h1><i class="fas fa-comments"></i> {t c='global.COMMENTS'}</h1>
						</div>
						<div class="float-left">
							<h1>
								<a id="comments_sort" href="#" data-id="{$photo.PID}" data-type="{$comment_section}" data-sort="newest" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-sort-amount-down"></i></a>
								<div class="dropdown-menu dropdown-menu-left" aria-labelledby="comments_sort">
									<a class="dropdown-item active" data-sort="newest" id="comments_sort_newest" href="#">
										{t c='comments.newest'}
									</a>							
									<a class="dropdown-item" data-sort="top" id="comments_sort_top" href="#">
										{t c='comments.top_comments'}
									</a>
								</div>							
							</h1>
						</div>
						<div class="float-left ml-3">
							<h1>
								<span id="sort_loading"></span>					
							</h1>
						</div>
						<div class="float-right">
							<h1><span id="comments_total">{$comments_total}</span></h1>
						</div>	
						<div class="clearfix"></div>
					</div>
					<div id="comments_input_container">
						<textarea data-id="{$photo.PID}" data-type="{$comment_section}" id="comments_input" rows="3"  maxlength="1000" class="form-control" {if !isset($smarty.session.uid)}disabled{/if}></textarea>
						<span id="comments_login_register" class="{if isset($smarty.session.uid)}d-none{/if}">{t c='comments.login_register'}</span>					
					</div>
					{if isset($smarty.session.uid)}
					<div id="comments_btn_container">
						<a id="post_comment" href="#" class="btn btn-secondary btn-sm">{t c='comments.post_comment'}</a>
						<span data-toggle="tooltip" data-placement="top" title="{t c='comments.insert_media'}"><a id="insert_media" href="#" class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#commentsMediaModal"><i class="fas fa-paperclip"></i></a></span>
						<span id="comment_response" class="comment-response"></span>
					</div>
					{/if}
					<div id="comments_list" class="comments-list">
					{if $comments}
						{section name=i loop=$comments}
						{insert name=time_range assign=addtime time=$comments[i].addtime}
						{insert name=comment_output assign=comment comment=$comments[i].message}	
						{insert name=total_replies assign=total_replies cid=$comments[i].CID type=$comment_section}	
						<div class="comment-item" id="comment_{$comments[i].CID}">
							<div class="comment-user">
								<a href="{$relative}/user/{$comments[i].username}">
									<img src="{$relative}/media/users/{if $comments[i].photo != ''}{$comments[i].photo}{else}nopic-{$comments[i].gender}.gif{/if}" alt="{$comments[i].username}">
								</a>						
							</div>    
							<div class="comment-info">
								<div class="comment-body">
									<div class="comment-actions">							
										<a id="comment_actions_{$comment_section}_{$comments[i].CID}" data-uid="{$comments[i].UID}" data-rel="{$comment_section}_{$comments[i].CID}" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<i class="fas fa-ellipsis-h"></i>
										</a>
										<div class="dropdown-menu dropdown-menu-right" aria-labelledby="comment_actions_{$comment_section}_{$comments[i].CID}">
											<a class="dropdown-item {if $smarty.session.uid == $comments[i].UID}d-none{/if}" id="report_comment_{$comment_section}_{$comments[i].CID}" href="#">
												<i class="fas fa-flag"></i> {t c='global.report_spam'}
											</a>							
											<a class="dropdown-item {if $smarty.session.uid != $comments[i].UID}d-none{/if}" id="delete_comment_{$comment_section}_{$comments[i].CID}" href="#">
												<i class="fas fa-trash"></i> {t c='global.delete'}
											</a>
										</div>					
									</div>
									<div class="comment-user-info">
										<a class="comment-username" href="{$relative}/user/{$comments[i].username}">{$comments[i].username}</a>
										<span class="comment-add-time"><i class="far fa-clock"></i>{$addtime}</span>	
									</div>
									<div class="comment-text">
										{$comment|nl2br}
									</div>
									<div class="comment-meta">
										<div class="vote-box">
											<span class="content-rating">
												<span class="vote-up mr-1"><i id="comment_vote_up_{$comment_section}_{$comments[i].CID}" class="fas fa-thumbs-up"></i><span id="comment_rate_{$comment_section}_{$comments[i].CID}">{$comments[i].rate}</span></span>		
												<span class="vote-down"><i id="comment_vote_down_{$comment_section}_{$comments[i].CID}" class="fas fa-thumbs-down"></i></span>						
											</span>	
										</div>
										<div class="comment-reply">
											<a id="comment_reply_{$comment_section}_{$comments[i].CID}" data-id="{$comments[i].CID}" data-type="{$comment_section}" data-reply-username="" class="" href="#"><i class="fas fa-share"></i>{t c='global.reply'}</a>								
										</div>
									</div>								
								</div>
							</div>
							<div class="comment-replies">
								<div class="comment-reply-container d-none" id="reply_container_{$comment_section}_{$comments[i].CID}"></div>
								<div class="comments-list replies-list" id="replies_more_{$comment_section}_{$comments[i].CID}"></div>
								<div class="comments-list replies-list" id="replies_list_{$comment_section}_{$comments[i].CID}"></div>
								{if $total_replies > 0}							
									<div id="replies_show_hide_container_{$comment_section}_{$comments[i].CID}" class="replies-show-hide-container">
										<a id="replies_show_more_{$comment_section}_{$comments[i].CID}" class="replies-show-more" data-page="1" data-type="{$comment_section}" data-id="{$comments[i].CID}" href="#">{if $total_replies == 1}{t c='comments.view_reply'}{else}{t c='comments.view_replies'} <span id="replies_total_{$comment_section}_{$comments[i].CID}">{$total_replies}</span>{/if}<i class="fas fa-chevron-down"></i></a>
										<a id="replies_show_more_{$comment_section}_{$comments[i].CID}_" class="replies-show-more replies-view-more" data-page="1" data-type="{$comment_section}" data-id="{$comments[i].CID}" href="#">{t c='comments.view_more_replies'} <span id="replies_total_{$comment_section}_{$comments[i].CID}_">0</span><i class="fas fa-chevron-down"></i></a>							
										<a id="replies_hide_{$comment_section}_{$comments[i].CID}" class="replies-hide" data-type="{$comment_section}" data-id="{$comments[i].CID}" href="#">{if $total_replies == 1}{t c='comments.hide_reply'}{else}{t c='comments.hide_replies'}{/if}<i class="fas fa-chevron-up"></i></a>
										<span class="reply-response" id="replies_loading_{$comment_section}_{$comments[i].CID}"></span>															
									</div>
								{/if}							
							</div>
						</div>					
						{/section}
					{/if}			
					</div>
					<div id="comments_more" class="comments-list">
					</div>				
					{if $comments_total > 10}
						<a href="#" id="comments_show_more" class="comments-show-more" data-page="2" data-type="{$comment_section}" data-id="{$photo.PID}">{t c='global.show_more'}<i class="fas fa-chevron-down"></i></a>
						<a href="#" id="comments_hide" class="comments-hide">{t c='global.hide'}<i class="fas fa-chevron-up"></i></a>
						<span id="comments_loading"></span>
					{/if}
				</div>
			{/if}
			
		</div>
		<div class="content-right mt-3 mb-3">
			{insert name=adv assign=adv group='photo_right'}
			{if $adv.ad}
			<div class="ad-content">
				{$adv.ad}
			</div>	
			{elseif $adv.help}		
				<div class="ad-body" style="width:{$adv.width}px;">
					<p class="ad-title"><span>{t c='global.sponsors'}</span><span class="ad-group">PHOTO RIGHT</span></p>
					<p class="ad-size">{$adv.width} &times; Auto</p>
				</div>			
			{/if}	
		</div>	
	</div>

	{insert name=adv assign=adv group='photo_bottom'}
	{if $adv.ad}		
	<div class="ad-content">
		{$adv.ad}
	</div>	
	{elseif $adv.help}		
		<div class="ad-body">
			<p class="ad-title"><span>{t c='global.sponsors'}</span><span class="ad-group">PHOTO BOTTOM</span></p>
			<p class="ad-size">Auto &times; Auto</p>
		</div>			
	{/if}		
</div>