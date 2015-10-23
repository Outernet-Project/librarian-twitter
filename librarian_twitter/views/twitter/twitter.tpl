<%inherit file="/narrow_base.tpl"/>
<%namespace name='tweet_list' file='_tweet_list.tpl'/>
<%namespace name='handle_selector' file='_handle_selector.tpl'/>

<%namespace name="ui" file="/ui/widgets.tpl"/>

<%block name="title">
## Translators, used as page title
${_('Twitter')}
</%block>

<%block name="extra_head">
    <link rel="stylesheet" href="${assets['css/twitter']}">
</%block>

<% section = request.params.get('section', 'tweets') %>

<div id="tabbable-twitter" class="o-tabbable">
    <ul class="o-tab-handles" role="tablist">
        <li class="o-tab-handle">
        ${ui.tab_activator(_('Tweets'), 'tweet', 'tweets-tab', active=section == 'tweets')}
        </li>
        <li class="o-tab-handle">
        ${ui.tab_activator(_('Handles'), 'atmark', 'handles-tab', active=section == 'handles')}
        </li>
    </ul>

    <div class="o-tab-panels">
        <%ui:tab_panel id="tweets-tab" expanded="${'true' if section == 'tweets' else ''}">
            % if not tweet_count:
                <div class="tweet-error">
                    <p>Sorry! No tweets could be found with the user name "${handle}"</p>
                </div>
            % else:
                % if handle:
                    <p class="twitter-note">
                        ${_('Showing tweets from @{handle}.').format(handle=handle)}
                        <a href="${i18n_url('twitter:list')}">
                            <span class="icon icon-arrow-left"></span>
                            <span>${_('Go back to all teweets')}</span>
                        </a>
                    </p>
                % endif
            % endif
            % for tweet in tweets:
                <div class="tweet" id="${tweet['id']}">
                    <p class="tweet-header">
                        <span class="twitter-icon icon icon-tweet"></span>
                        <span class="tweet-handle">
                            <a href="${i18n_url('twitter:list', h=tweet['handle'])}">
                                @${tweet['handle']}
                            </a>
                        </span>
                    </p>
                    <p class="tweet-text">
                        ${tweet['text']}
                    </p>
                    % if tweet['image']:
                        <p class="tweet-img">
                            <img src="${tweet.image_path}" alt="image">
                        </p>
                    % endif
                    <span class="tweet-timestamp">
                        <time datetime="${tweet['created'].isoformat()}">
                        ${tweet['created'].strftime('%Y-%m-%d %H:%M UTC')}
                        </time>
                    </span>
                </div>
            % endfor
            <%namespace name="p" file="/ui/pager.tpl"/>
            ${p.pager_links(pager, 'prev', 'next')}
        </%ui:tab_panel>

        <%ui:tab_panel id="handles-tab" expanded="${'true' if section == 'handles' else ''}">
            <p>
                <input type="text" id="handle-filter" placeholder="Filter by handle (username)">
            </p>
            <div id="handle-list">
                % for handle in handles:
                    <a class="handle" href="${i18n_url('twitter:list', h=handle[0])}">
                        @${handle[0]}
                    </a>
                % endfor
            </div>
        </%ui:tab_panel>
    </div>
</div>

<%block name="extra_scripts">
    <script type="text/javascript">
        window.twitterBaseUrl = "${i18n_url('twitter:list')}?section=";
    </script>
    <script src="${assets['js/twitter']}"></script>
</%block>
