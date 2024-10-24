import Component from "@glimmer/component";
import { fn } from "@ember/helper";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import { service } from "@ember/service";
import i18n from "discourse-common/helpers/i18n";
import dIcon from "discourse-common/helpers/d-icon";

export default class MessageButton extends Component {
  @service router;
  @service chatStateManager;
  @service chatTrackingStateManager;

  get notificationCount() {
    return this.chatTrackingStateManager.directMessageUnreadCount;
  }

  get showNotificationCount() {
    return this.notificationCount > 0;
  }

  @action
  async click() {
    this.chatStateManager.prefersDrawer();
    const channel = this.args.channel;
    this.router.transitionTo(`/chat/c/${channel.slugifiedTitle}/${channel.id}`);
  }

  <template>
    {{#if @channel}}
      <a
        id="support-button"
        class="support-button"
        {{on "click" this.click}}
        role="button"
      >
        {{#if this.showNotificationCount}}
          <span
            class="support-button-notification-count"
          >{{this.notificationCount}}</span>
        {{/if}}
        {{dIcon "d-chat"}}
      </a>
    {{/if}}
  </template>
}
