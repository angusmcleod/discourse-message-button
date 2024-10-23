import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import { tracked } from "@glimmer/tracking";

const username = 'angus';
const allowedGroups = ['subscribers'];

export default class MessageButtonContainer extends Component {
  @service chat;
  @service currentUser;
  @tracked channel;

  constructor() {
    super(...arguments);

    if (this.currentUser) {
      this.chat.upsertDmChannel({ usernames: [username] }).then(channel => {
        this.channel = channel;
      });
    }
  }
}