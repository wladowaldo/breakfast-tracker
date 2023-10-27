import axios from 'axios';

export default axios.create({
    baseURL: `${location.protocol}//${location.hostname}:7256`,
});
